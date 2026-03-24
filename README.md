# CSDK Docs — Claude Code Skill

Claude Code slash commands that give Claude access to the full Sisense Compose SDK documentation for accurate, context-aware answers.

## Install

Clone this repo, then use Claude Code from within it:

```bash
git clone https://github.com/pmorris24/csdk-docs-skill.git
cd csdk-docs-skill
claude
```

Or add it to an existing project as a submodule:

```bash
git submodule add https://github.com/pmorris24/csdk-docs-skill.git .csdk-docs
cp -r .csdk-docs/.claude/commands/csdk-*.md .claude/commands/
```

## Commands

| Command | Use case | Context loaded |
|---------|----------|----------------|
| `/csdk-quick` | Fast lookups — "what does filterFactory.members do?" | ~20-50 KB |
| `/csdk-react` | React-specific questions | Only relevant React docs |
| `/csdk-vue` | Vue-specific questions | Only relevant Vue docs |
| `/csdk-angular` | Angular-specific questions | Only relevant Angular docs |
| `/csdk-docs` | General questions (auto-detects framework) | Only relevant docs |

## Examples

```
/csdk-quick what props does useExecuteQuery accept?
```

```
/csdk-react how do I embed a dashboard with custom filters?
```

```
/csdk-vue how do I create a bar chart with drilldown?
```

```
/csdk-docs how do I migrate from 1.x to 2.0?
```

## How it works

Each command uses an **index-first approach**:

1. Claude reads a small INDEX.md file (~4 KB) that lists every doc file and what it contains
2. Based on your question, Claude picks only the relevant files to read
3. This keeps context usage minimal — typically 20-100 KB instead of the full 3 MB doc set

Docs are split into ~50 focused files organized by:

- **Framework** (`docs/react/`, `docs/vue/`, `docs/angular/`) — charts, dashboards, contexts, and interface files split by category (chart, dashboard, filter, theme, data, AI, interaction)
- **Data API** (`docs/data/`) — factories and individual functions
- **Guides** (`docs/guides/`) — 22 topic-specific guides (quickstarts, theming, drilldown, dashboards, tutorials, troubleshooting, etc.)
- **Design** — chart design, UX guidance, supplemental notes

## Updating docs

When Sisense releases a new SDK version, rebuild the docs from a fresh `chunks.json`:

```bash
# From the playground's public assets
./scripts/update-docs.sh /path/to/chunks.json

# Or directly from a deployed playground URL
./scripts/update-docs.sh https://ai-playground-prod-2.vercel.app/rag_index/chunks.json
```

This re-splits all files, rebuilds indexes, and categorizes interfaces automatically.

## Supported frameworks

- React
- Vue
- Angular
