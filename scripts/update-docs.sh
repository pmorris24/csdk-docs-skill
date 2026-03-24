#!/bin/bash
# Update CSDK docs from the official Sisense Compose SDK monorepo.
#
# Usage:
#   ./scripts/update-docs.sh
#   ./scripts/update-docs.sh --branch dev    # use a specific branch
#
# Clones the docs-md/sdk/ directory from the monorepo and rebuilds all
# split doc files and INDEX.md files. No chunks.json or playground URL needed.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
DOCS_DIR="$REPO_DIR/docs"
MONOREPO="https://github.com/sisense/compose-sdk-monorepo.git"
BRANCH="main"

# Parse optional --branch flag
while [[ $# -gt 0 ]]; do
  case "$1" in
    --branch) BRANCH="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

echo "Fetching docs from sisense/compose-sdk-monorepo (branch: $BRANCH)..."

# Create temp dir for clone
TMPDIR=$(mktemp -d /tmp/csdk-monorepo.XXXXXX)
trap "rm -rf $TMPDIR" EXIT

# Sparse checkout: only docs-md/sdk/
git clone --depth 1 --branch "$BRANCH" --filter=blob:none --sparse \
  "$MONOREPO" "$TMPDIR/repo" 2>&1 | tail -1
cd "$TMPDIR/repo"
git sparse-checkout set docs-md/sdk 2>/dev/null
cd - >/dev/null

SRC="$TMPDIR/repo/docs-md/sdk"

if [ ! -d "$SRC" ]; then
  echo "ERROR: docs-md/sdk/ not found in monorepo clone"
  exit 1
fi

echo "Source fetched. Rebuilding docs..."

# ── Clean existing generated dirs ──
for d in react vue angular data guides; do
  rm -rf "$DOCS_DIR/$d"
done

# ── Guides ──
# Flatten all guides markdown into docs/guides/
GUIDES_OUT="$DOCS_DIR/guides"
mkdir -p "$GUIDES_OUT"

# getting-started/ -> guides/
for f in "$SRC/getting-started/"*.md; do
  [ -f "$f" ] || continue
  name=$(basename "$f")
  [ "$name" = "index.md" ] && continue
  cp "$f" "$GUIDES_OUT/$name"
done

# guides/ top-level files
for f in "$SRC/guides/"*.md; do
  [ -f "$f" ] || continue
  name=$(basename "$f")
  [ "$name" = "index.md" ] && continue
  cp "$f" "$GUIDES_OUT/$name"
done

# guides/ subdirectories — concatenate each subdir's files into one doc
for subdir in "$SRC/guides/"*/; do
  [ -d "$subdir" ] || continue
  dirname=$(basename "$subdir")
  outfile="$GUIDES_OUT/$dirname.md"
  first=true
  for f in "$subdir"*.md; do
    [ -f "$f" ] || continue
    name=$(basename "$f")
    [ "$name" = "index.md" ] && continue
    if [ "$first" = true ]; then
      first=false
    else
      echo -e "\n\n---\n" >> "$outfile"
    fi
    cat "$f" >> "$outfile"
  done
done

# troubleshooting/ -> guides/troubleshooting.md (concatenate all files)
if [ -d "$SRC/troubleshooting" ]; then
  outfile="$GUIDES_OUT/troubleshooting.md"
  : > "$outfile"
  first=true
  for f in "$SRC/troubleshooting/"*.md; do
    [ -f "$f" ] || continue
    name=$(basename "$f")
    [ "$name" = "index.md" ] && continue
    if [ "$first" = true ]; then
      first=false
    else
      echo -e "\n\n---\n" >> "$outfile"
    fi
    cat "$f" >> "$outfile"
  done
fi

# tutorials/ -> guides/tutorials.md (concatenate all lessons)
if [ -d "$SRC/tutorials" ]; then
  outfile="$GUIDES_OUT/tutorials.md"
  : > "$outfile"
  first=true
  for tdir in "$SRC/tutorials/"*/; do
    [ -d "$tdir" ] || continue
    for f in "$tdir"*.md; do
      [ -f "$f" ] || continue
      name=$(basename "$f")
      [ "$name" = "index.md" ] && continue
      if [ "$first" = true ]; then
        first=false
      else
        echo -e "\n\n---\n" >> "$outfile"
      fi
      cat "$f" >> "$outfile"
    done
  done
fi

# reference/ -> guides/formula-functions.md
if [ -f "$SRC/reference/functions.md" ]; then
  cp "$SRC/reference/functions.md" "$GUIDES_OUT/formula-functions.md"
fi

echo "  guides/ done ($(ls "$GUIDES_OUT"/*.md 2>/dev/null | wc -l | tr -d ' ') files)"

# ── Framework APIs (react, vue, angular) ──
# Each framework module has subdirs: charts/, contexts/, dashboards/, data-grids/,
# drilldown/, filter-tiles/, fusion-assets/, generative-ai/, interfaces/, queries/, type-aliases/
#
# Strategy: concatenate each category's .md files into one file per category,
# then group interfaces + type-aliases into categorized files for manageable size.

process_framework() {
  local fw_name="$1"    # react, vue, angular
  local module="$2"     # sdk-ui, sdk-ui-vue, sdk-ui-angular
  local src_dir="$SRC/modules/$module"
  local out_dir="$DOCS_DIR/$fw_name"

  if [ ! -d "$src_dir" ]; then
    echo "  WARNING: $src_dir not found, skipping $fw_name"
    return
  fi

  mkdir -p "$out_dir"

  # Simple category dirs -> single concatenated file
  for category in charts contexts dashboards data-grids drilldown filter-tiles fusion-assets generative-ai queries; do
    local cat_dir="$src_dir/$category"
    [ -d "$cat_dir" ] || continue
    local outfile="$out_dir/$category.md"
    : > "$outfile"
    local first=true

    # Collect all .md files recursively (handles namespace subdirs)
    while IFS= read -r -d '' f; do
      name=$(basename "$f")
      [ "$name" = "index.md" ] && continue
      if [ "$first" = true ]; then
        first=false
      else
        echo -e "\n\n---\n" >> "$outfile"
      fi
      cat "$f" >> "$outfile"
    done < <(find "$cat_dir" -name '*.md' -print0 | sort -z)

    # Remove empty files
    if [ ! -s "$outfile" ]; then
      rm -f "$outfile"
    fi
  done

  # Interfaces -> categorized files (to keep size manageable)
  local iface_dir="$src_dir/interfaces"
  if [ -d "$iface_dir" ]; then
    # Temporary: collect all interface content with filenames for categorization
    for f in "$iface_dir/"*.md; do
      [ -f "$f" ] || continue
      name=$(basename "$f")
      [ "$name" = "index.md" ] && continue

      name_lower=$(echo "$name" | tr '[:upper:]' '[:lower:]')

      # Categorize by filename keywords
      local cat="other-interfaces"
      if echo "$name_lower" | grep -qE 'chart|axis|legend|tooltip|series|polar|funnel|scatter|treemap|sunburst|indicator|boxplot|area|bar|column|line|pie|waterfall|stacked|streamgraph|range|cartesian|categorical|calendarh'; then
        cat="chart-interfaces"
      elif echo "$name_lower" | grep -qE 'dashboard|widget|pivot|composed|text'; then
        cat="dashboard-interfaces"
      elif echo "$name_lower" | grep -qE 'filter|cascading|criteria|member|filtersPanel'; then
        cat="filter-interfaces"
      elif echo "$name_lower" | grep -qE 'theme|palette|typography'; then
        cat="theme-interfaces"
      elif echo "$name_lower" | grep -qE 'data|measure|dimension|attribute|column|category|value|sort|query|execute|csv|custom'; then
        cat="data-interfaces"
      elif echo "$name_lower" | grep -qE 'drill|context.menu|breadcrumb|selection'; then
        cat="interaction-interfaces"
      elif echo "$name_lower" | grep -qE 'nlg|nlq|chatbot|ai|chat'; then
        cat="ai-interfaces"
      fi

      local outfile="$out_dir/$cat.md"
      if [ -f "$outfile" ]; then
        echo -e "\n\n---\n" >> "$outfile"
      fi
      cat "$f" >> "$outfile"
    done
  fi

  # Type aliases -> concatenated into type-aliases.md (or merged into interface categories)
  local ta_dir="$src_dir/type-aliases"
  if [ -d "$ta_dir" ]; then
    local outfile="$out_dir/type-aliases.md"
    : > "$outfile"
    local first=true
    for f in "$ta_dir/"*.md; do
      [ -f "$f" ] || continue
      name=$(basename "$f")
      [ "$name" = "index.md" ] && continue
      if [ "$first" = true ]; then
        first=false
      else
        echo -e "\n\n---\n" >> "$outfile"
      fi
      cat "$f" >> "$outfile"
    done
    if [ ! -s "$outfile" ]; then
      rm -f "$outfile"
    fi
  fi

  local count=$(ls "$out_dir/"*.md 2>/dev/null | wc -l | tr -d ' ')
  echo "  $fw_name/ done ($count files)"
}

process_framework "react" "sdk-ui"
process_framework "vue" "sdk-ui-vue"
process_framework "angular" "sdk-ui-angular"

# ── Data API (sdk-data) ──
DATA_OUT="$DOCS_DIR/data"
mkdir -p "$DATA_OUT"
DATA_SRC="$SRC/modules/sdk-data"

if [ -d "$DATA_SRC" ]; then
  # factories/ -> data/factories.md (filterFactory, measureFactory, analyticsFactory)
  if [ -d "$DATA_SRC/factories" ]; then
    outfile="$DATA_OUT/factories.md"
    : > "$outfile"
    first=true
    while IFS= read -r -d '' f; do
      name=$(basename "$f")
      [ "$name" = "index.md" ] && continue
      if [ "$first" = true ]; then
        first=false
      else
        echo -e "\n\n---\n" >> "$outfile"
      fi
      cat "$f" >> "$outfile"
    done < <(find "$DATA_SRC/factories" -name '*.md' -print0 | sort -z)
  fi

  # Remaining subdirs -> data/functions.md (data-model-utilities, filter-utilities, interfaces, type-aliases, enumerations, variables)
  outfile="$DATA_OUT/functions.md"
  : > "$outfile"
  first=true
  for subdir in data-model-utilities filter-utilities enumerations variables interfaces type-aliases; do
    local_dir="$DATA_SRC/$subdir"
    [ -d "$local_dir" ] || continue
    while IFS= read -r -d '' f; do
      name=$(basename "$f")
      [ "$name" = "index.md" ] && continue
      if [ "$first" = true ]; then
        first=false
      else
        echo -e "\n\n---\n" >> "$outfile"
      fi
      cat "$f" >> "$outfile"
    done < <(find "$local_dir" -name '*.md' -print0 | sort -z)
  done

  echo "  data/ done ($(ls "$DATA_OUT/"*.md 2>/dev/null | wc -l | tr -d ' ') files)"
fi

# ── Build INDEX.md files ──
echo ""
echo "Building indexes..."

build_index() {
  local dir="$1"
  local dir_path="$DOCS_DIR/$dir"
  [ -d "$dir_path" ] || return

  local index_file="$dir_path/INDEX.md"
  echo "# Index: $dir/" > "$index_file"
  echo "" >> "$index_file"
  echo "Use this index to decide which file to read. Only read files relevant to the question." >> "$index_file"
  echo "" >> "$index_file"

  for f in "$dir_path/"*.md; do
    [ -f "$f" ] || continue
    name=$(basename "$f")
    [ "$name" = "INDEX.md" ] && continue

    local size=$(( $(wc -c < "$f") / 1024 ))

    # Extract h1 headings (first 30 unique)
    local headings=$(grep -E '^# ' "$f" | sed 's/^# \(Function \|Class \|Interface \|Type Alias \|Namespace \)\?//' | head -30 | sort -u | paste -sd ', ' -)

    echo "### $name ($size KB)" >> "$index_file"
    [ -n "$headings" ] && echo "$headings" >> "$index_file"
    echo "" >> "$index_file"
  done
}

for d in react vue angular data guides; do
  build_index "$d"
done

echo ""
echo "Docs updated successfully."
echo ""
echo "Summary:"
for d in react vue angular data guides; do
  if [ -d "$DOCS_DIR/$d" ]; then
    count=$(ls "$DOCS_DIR/$d/"*.md 2>/dev/null | grep -v INDEX.md | wc -l | tr -d ' ')
    size=$(du -sh "$DOCS_DIR/$d" 2>/dev/null | cut -f1)
    echo "  $d/: $count files, $size"
  fi
done
