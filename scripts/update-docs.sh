#!/bin/bash
# Update CSDK docs from a playground's chunks.json
#
# Usage:
#   ./scripts/update-docs.sh /path/to/chunks.json
#   ./scripts/update-docs.sh https://ai-playground-prod-2.vercel.app/rag_index/chunks.json
#
# This rebuilds all split doc files from a fresh chunks.json export.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
DOCS_DIR="$REPO_DIR/docs"
CHUNKS_SOURCE="${1:?Usage: $0 <path-or-url-to-chunks.json>}"

# Download or copy chunks.json to temp
TMPFILE=$(mktemp /tmp/chunks.XXXXXX.json)
trap "rm -f $TMPFILE" EXIT

if [[ "$CHUNKS_SOURCE" == http* ]]; then
  echo "Downloading chunks.json..."
  curl -sL "$CHUNKS_SOURCE" -o "$TMPFILE"
else
  cp "$CHUNKS_SOURCE" "$TMPFILE"
fi

echo "Rebuilding docs from chunks.json..."

python3 << PYEOF
import json, os, re, sys

with open("$TMPFILE") as f:
    chunks = json.load(f)

print(f"Loaded {len(chunks)} chunks")

# ── Step 1: Reconstruct source markdown files ──
sources = {}
for c in chunks:
    s = c['source']
    if s not in sources:
        sources[s] = []
    sources[s].append(c['text'])

DOCS_DIR = "$DOCS_DIR"

# Clean existing split dirs
import shutil
for d in ['react', 'vue', 'angular', 'data', 'guides']:
    path = os.path.join(DOCS_DIR, d)
    if os.path.exists(path):
        shutil.rmtree(path)

# Write reconstructed source files to temp
TMPDIR = "/tmp/csdk_raw"
os.makedirs(TMPDIR, exist_ok=True)

for source, texts in sources.items():
    fname = source if source.endswith('.md') else source + '.md'
    with open(f"{TMPDIR}/{fname}", 'w') as f:
        f.write('\n\n'.join(texts))
    print(f"  Reconstructed {fname}")

# ── Step 2: Split guides ──
def read_raw(name):
    path = f"{TMPDIR}/{name}"
    if not os.path.exists(path):
        return None
    with open(path) as f:
        return f.read()

def write_doc(relpath, content):
    content = content.strip()
    if len(content) < 50:
        return
    path = os.path.join(DOCS_DIR, relpath)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w') as f:
        f.write(content + '\n')
    print(f"  {relpath} ({len(content)//1024} KB)")

guides = read_raw('csdk_guides.md')
if guides:
    lines = guides.split('\n')

    # Build a line-number index of h1 headings
    h1s = []
    for i, line in enumerate(lines):
        if line.startswith('# '):
            h1s.append((i, line))

    def lines_between(start, end):
        return '\n'.join(lines[start:end])

    # Find sections by scanning h1 headings
    splits = {
        'authentication': (r'Authentication & Security', r'Quickstart|Compose SDK with'),
        'quickstart-react': (r'(Compose SDK with React|Quickstart.*React)', r'(Compose SDK with Angular|Quickstart.*Angular)'),
        'quickstart-angular': (r'(Compose SDK with Angular|Quickstart.*Angular)', r'(Compose SDK with Vue|Quickstart.*Vue)'),
        'quickstart-vue': (r'(Compose SDK with Vue|Quickstart.*Vue)', r'^# Guides$'),
        'cli': (r'^# CLI$', r'Client Query Caching'),
        'query-caching': (r'Client Query Caching', r'^# Data Model$'),
        'data-model': (r'^# Data Model$', r'Number.*Date Formatting'),
        'number-date-formatting': (r'Number.*Date Formatting', r'Internationalization'),
        'internationalization': (r'Internationalization', r'Jest'),
        'jest-setup': (r'Jest', r'Migrat'),
        'migration-0x-to-1x': (r'Migrat.*0.*1', r'Migrat.*1.*2'),
        'migration-1x-to-2x': (r'Migrat.*1.*2', r'Theming'),
        'theming': (r'Theming', r'Generative AI'),
        'generative-ai': (r'Generative AI', r'Chart Types'),
        'chart-types': (r'^# Chart Types', r'External Charts'),
        'external-charts': (r'External Charts', r'Custom Widget'),
        'custom-widgets': (r'Custom Widget', r'Embedded Dashboard'),
        'embedded-dashboards': (r'Embedded Dashboard', r'^# Drilldown$'),
        'drilldown': (r'^# Drilldown$', r'^# Tutorials?$'),
        'tutorials': (r'^# Tutorials?$', r'^# Troubleshooting'),
        'troubleshooting': (r'^# Troubleshooting', r'^# Reference'),
        'formula-functions': (r'^# (Reference|Formula)', r'^# CROSS-FRAMEWORK'),
    }

    print("\nSplitting guides...")
    for name, (start_pat, end_pat) in splits.items():
        start_line = None
        end_line = None
        for i, line in h1s:
            if start_line is None and re.search(start_pat, line):
                start_line = i
            elif start_line is not None and re.search(end_pat, line):
                end_line = i
                break
        if start_line is not None:
            content = lines_between(start_line, end_line if end_line else len(lines))
            write_doc(f'guides/{name}.md', content)

# ── Step 3: Split framework API files ──
print("\nSplitting framework APIs...")
for fw, filename in [('react', 'csdk_api_sdk_ui.md'), ('vue', 'csdk_api_sdk_ui_vue.md'), ('angular', 'csdk_api_sdk_ui_angular.md')]:
    api = read_raw(filename)
    if not api:
        continue
    api_lines = api.split('\n')

    contexts_start = charts_start = dash_start = interfaces_start = None

    for i, line in enumerate(api_lines):
        if line.startswith('# Contexts') and not contexts_start:
            contexts_start = i
        if re.match(r'^# (Function |Class )?(Area)?Chart(Component)?$', line) and not charts_start:
            charts_start = i
        if re.match(r'^# (Function |Class )?AreaChart', line) and not charts_start:
            charts_start = i
        if re.match(r'^# (Function |Class )?ChartWidget', line) and not dash_start:
            dash_start = i
        if re.match(r'^# (Function |Class )?Dashboard(Component)?$', line) and not dash_start:
            dash_start = i
        if re.match(r'^# Interface ', line) and not interfaces_start:
            interfaces_start = i
        if re.match(r'^# Type [Aa]lias', line) and not interfaces_start:
            interfaces_start = i

    if contexts_start and charts_start:
        write_doc(f'{fw}/contexts.md', '\n'.join(api_lines[contexts_start:charts_start]))
    if charts_start and dash_start:
        write_doc(f'{fw}/charts.md', '\n'.join(api_lines[charts_start:dash_start]))
    if dash_start and interfaces_start:
        write_doc(f'{fw}/dashboards.md', '\n'.join(api_lines[dash_start:interfaces_start]))
    elif dash_start:
        write_doc(f'{fw}/dashboards.md', '\n'.join(api_lines[dash_start:]))
    if interfaces_start:
        # Split interfaces into smaller files by category
        iface_lines = api_lines[interfaces_start:]
        current_section = []
        current_name = None
        iface_files = {}

        for line in iface_lines:
            m = re.match(r'^# (Interface|Type Alias) (.+)', line)
            if m:
                if current_name and current_section:
                    # Categorize
                    name_lower = current_name.lower()
                    if any(k in name_lower for k in ['chart', 'axis', 'legend', 'tooltip', 'series', 'polar', 'funnel', 'scatter', 'treemap', 'sunburst', 'indicator', 'boxplot', 'area', 'bar', 'column', 'line', 'pie', 'waterfall', 'stacked']):
                        cat = 'chart-interfaces'
                    elif any(k in name_lower for k in ['dashboard', 'widget', 'pivot']):
                        cat = 'dashboard-interfaces'
                    elif any(k in name_lower for k in ['filter', 'cascading', 'criteria', 'member']):
                        cat = 'filter-interfaces'
                    elif any(k in name_lower for k in ['theme', 'palette', 'typography']):
                        cat = 'theme-interfaces'
                    elif any(k in name_lower for k in ['data', 'measure', 'dimension', 'attribute', 'column', 'category', 'value', 'sort']):
                        cat = 'data-interfaces'
                    elif any(k in name_lower for k in ['drill', 'context.menu', 'breadcrumb', 'selection']):
                        cat = 'interaction-interfaces'
                    elif any(k in name_lower for k in ['nlg', 'nlq', 'chatbot', 'ai']):
                        cat = 'ai-interfaces'
                    else:
                        cat = 'other-interfaces'

                    if cat not in iface_files:
                        iface_files[cat] = []
                    iface_files[cat].extend(current_section)

                current_name = m.group(2)
                current_section = [line]
            else:
                current_section.append(line)

        # Don't forget last section
        if current_name and current_section:
            name_lower = current_name.lower()
            if any(k in name_lower for k in ['chart', 'axis', 'legend', 'tooltip', 'series']):
                cat = 'chart-interfaces'
            elif any(k in name_lower for k in ['dashboard', 'widget', 'pivot']):
                cat = 'dashboard-interfaces'
            elif any(k in name_lower for k in ['filter']):
                cat = 'filter-interfaces'
            elif any(k in name_lower for k in ['theme', 'palette']):
                cat = 'theme-interfaces'
            elif any(k in name_lower for k in ['data', 'measure', 'dimension']):
                cat = 'data-interfaces'
            else:
                cat = 'other-interfaces'
            if cat not in iface_files:
                iface_files[cat] = []
            iface_files[cat].extend(current_section)

        for cat, content_lines in iface_files.items():
            write_doc(f'{fw}/{cat}.md', '\n'.join(content_lines))

# ── Step 4: Split data API ──
print("\nSplitting data API...")
data = read_raw('csdk_api_sdk_data.md')
if data:
    data_lines = data.split('\n')
    func_start = None
    for i, line in enumerate(data_lines):
        if re.match(r'^# Function ', line):
            func_start = i
            break
    if func_start:
        write_doc('data/factories.md', '\n'.join(data_lines[:func_start]))
        write_doc('data/functions.md', '\n'.join(data_lines[func_start:]))
    else:
        write_doc('data/all.md', '\n'.join(data_lines))

# ── Step 5: Copy supplemental files ──
print("\nCopying supplemental files...")
for name in ['csdk_supplemental.md', 'csdk_chart_design.md', 'csdk_ui_ux_skill.md']:
    content = read_raw(name)
    if content:
        write_doc(name, content)

# ── Step 6: Build index files ──
print("\nBuilding index files...")

def build_index(directory):
    """Create an INDEX.md listing all files and their h1 headings."""
    entries = []
    dir_path = os.path.join(DOCS_DIR, directory)
    if not os.path.exists(dir_path):
        return
    for fname in sorted(os.listdir(dir_path)):
        if not fname.endswith('.md') or fname == 'INDEX.md':
            continue
        fpath = os.path.join(dir_path, fname)
        headings = []
        with open(fpath) as f:
            for line in f:
                m = re.match(r'^# (?:Function |Class |Interface |Type Alias |Namespace )?(.+)', line)
                if m:
                    headings.append(m.group(1).strip())
        size = os.path.getsize(fpath) // 1024
        # Deduplicate and limit headings
        seen = set()
        unique = []
        for h in headings:
            if h not in seen:
                seen.add(h)
                unique.append(h)
        sample = unique[:30]
        entries.append(f"### {fname} ({size} KB)\n{', '.join(sample)}")

    if entries:
        index_content = f"# Index: {directory}/\n\nUse this index to decide which file to read. Only read files relevant to the question.\n\n" + '\n\n'.join(entries)
        write_doc(f'{directory}/INDEX.md', index_content)

for d in ['react', 'vue', 'angular', 'data', 'guides']:
    build_index(d)

# Cleanup
shutil.rmtree(TMPDIR, ignore_errors=True)

print("\nDone!")
PYEOF

echo ""
echo "Docs updated successfully."
