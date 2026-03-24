# CSDK Docs — Claude Code Skill

Claude Code slash commands that give Claude access to the full Sisense Compose SDK documentation for accurate, context-aware answers.

## Install

```bash
git clone https://github.com/pmorris24/csdk-docs-skill.git
cd csdk-docs-skill
claude
```

Or add to an existing project:

```bash
git submodule add https://github.com/pmorris24/csdk-docs-skill.git .csdk-docs
cp -r .csdk-docs/.claude/commands/csdk-*.md .claude/commands/
```

## Commands

| Command | Use case | Context loaded |
|---------|----------|----------------|
| `/csdk-quick` | Fast lookups | ~20-50 KB |
| `/csdk-react` | React-specific questions | Only relevant React docs |
| `/csdk-vue` | Vue-specific questions | Only relevant Vue docs |
| `/csdk-angular` | Angular-specific questions | Only relevant Angular docs |
| `/csdk-docs` | General questions (auto-detects framework) | Only relevant docs |

## Examples

### Quick lookups

```
/csdk-quick what props does useExecuteQuery accept
```

```
/csdk-quick how do I use filterFactory.members to filter by specific values
```

```
/csdk-quick what is the difference between measureFactory.sum and measureFactory.count
```

```
/csdk-quick how do I set dataOptions on a chart
```

### React

```
/csdk-react how do I set up SisenseContextProvider with authentication
```

```
/csdk-react how do I query data with useExecuteQuery and display it in a ColumnChart
```

```
/csdk-react how do I embed an existing Fusion dashboard using DashboardById
```

```
/csdk-react how do I decompose a dashboard with useGetDashboardModel and dashboardModelTranslator
```

```
/csdk-react how do I add drilldown to a chart
```

```
/csdk-react how do I customize chart colors and styling with styleOptions
```

```
/csdk-react how do I use onBeforeRender to modify Highcharts options directly
```

```
/csdk-react how do I build a custom dashboard layout with useComposedDashboard
```

```
/csdk-react how do I use ChartWidget to render a widget from a Fusion dashboard
```

```
/csdk-react how do I add a PivotTable with custom dataOptions
```

```
/csdk-react how do I set up the Chatbot component for natural language queries
```

### Vue

```
/csdk-vue how do I set up SisenseContextProvider in a Vue app
```

```
/csdk-vue how do I embed a Fusion dashboard with DashboardById
```

```
/csdk-vue how do I apply a custom theme using ThemeProvider
```

```
/csdk-vue how do I create a PieChart with filterFactory.members
```

### Angular

```
/csdk-angular how do I configure SdkUiModule in my app module
```

```
/csdk-angular how do I use the DashboardComponent with WidgetsPanelColumnLayout
```

```
/csdk-angular how do I create an IndicatorChart with gauge styling
```

```
/csdk-angular how do I use widgetModelTranslator to customize a Fusion widget
```

### General

```
/csdk-docs how do I generate a data model from my Sisense instance
```

```
/csdk-docs how do I use external chart libraries like Recharts with Sisense data
```

```
/csdk-docs what changed in the migration from 1.x to 2.0
```

```
/csdk-docs how do I troubleshoot CORS issues with my Sisense server
```

```
/csdk-docs how do I set up the NLG chatbot with generative AI
```

```
/csdk-docs what formula functions are available for calculated measures
```

```
/csdk-docs how do I add internationalization to my Compose SDK app
```

## How it works

Each command uses an **index-first approach**:

1. Claude reads a small INDEX.md file (~4 KB) that lists every doc file and what it contains
2. Based on your question, Claude picks only the relevant files to read
3. This keeps context usage minimal — typically 20-100 KB instead of the full 3 MB doc set

Docs are split into ~50 focused files organized by:

- **Framework** (`docs/react/`, `docs/vue/`, `docs/angular/`) — charts, dashboards, contexts, and interface files split by category
- **Data API** (`docs/data/`) — factories and individual functions
- **Guides** (`docs/guides/`) — 22 topic-specific guides
- **Design** — chart design, UX guidance, supplemental notes

## Want TF-IDF search instead?

Check out [csdk-docs-mcp](https://github.com/pmorris24/csdk-docs-mcp) — an MCP server that provides real TF-IDF search over the same docs. Works with Claude Code, Claude Desktop, or any MCP client.

## Updating docs

Docs are pulled directly from the official [Sisense Compose SDK monorepo](https://github.com/sisense/compose-sdk-monorepo) (`docs-md/sdk/`). When Sisense releases a new SDK version:

```bash
./scripts/update-docs.sh
```

To pull from a specific branch:

```bash
./scripts/update-docs.sh --branch dev
```
## Supported frameworks

- React
- Vue
- Angular
