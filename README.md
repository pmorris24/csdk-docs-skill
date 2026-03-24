# CSDK Docs — Claude Code Skill + MCP Server

Claude Code slash commands and an MCP server that give Claude access to the full Sisense Compose SDK documentation for accurate, context-aware answers.

## Two ways to use it

| Method | How it works | Best for |
|--------|-------------|----------|
| **Slash commands** | Claude reads index files, picks relevant docs | Quick questions, browsing docs |
| **MCP server** | TF-IDF search returns the most relevant chunks automatically | Precise lookups, code-aware search |

## Install

```bash
git clone https://github.com/pmorris24/CSDK-Docs-Claude-Code-Skill-MCP-Server.git
cd csdk-docs-skill
```

### Slash commands (works immediately)

Just open Claude Code in this directory — the `/csdk-*` commands are available automatically.

### MCP server (TF-IDF search)

Build and connect:

```bash
cd mcp-server && npm install && npm run build && cd ..
```

The `.mcp.json` is already configured. Claude Code will detect it and connect automatically. You can also add it to any project:

```json
{
  "mcpServers": {
    "csdk-docs": {
      "command": "node",
      "args": ["/absolute/path/to/csdk-docs-skill/mcp-server/dist/index.js"]
    }
  }
}
```

Or for Claude Desktop (`~/Library/Application Support/Claude/claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "csdk-docs": {
      "command": "node",
      "args": ["/absolute/path/to/csdk-docs-skill/mcp-server/dist/index.js"]
    }
  }
}
```

## MCP server tools

| Tool | Description |
|------|-------------|
| `search_csdk_docs` | TF-IDF search over 2,000+ doc chunks. Accepts query, optional framework filter, and optional code context for smarter results. |
| `list_csdk_topics` | Lists all available documentation topics and categories. |

The `search_csdk_docs` tool accepts a `code_context` parameter — pass in the current file's code and it will extract SDK imports, components, hooks, and factories to boost relevant docs. This is the same algorithm used in the playground's AI agent.

## Slash commands

| Command | Use case | Context loaded |
|---------|----------|----------------|
| `/csdk-quick` | Fast lookups | ~20-50 KB |
| `/csdk-react` | React-specific questions | Only relevant React docs |
| `/csdk-vue` | Vue-specific questions | Only relevant Vue docs |
| `/csdk-angular` | Angular-specific questions | Only relevant Angular docs |
| `/csdk-docs` | General questions (auto-detects framework) | Only relevant docs |

## Examples

### Quick lookups — fast answers to common questions

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

### React — building dashboards and charts

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

### Vue — same features, Vue syntax

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

### Angular — same features, Angular syntax

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

### General — guides, migration, troubleshooting

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

### MCP server — automatic, no slash command needed

With the MCP server running, Claude will automatically search the docs when it needs SDK information. Just ask naturally:

```
"How do I create a scatter chart with custom tooltips?"
"What are the props for ChartWidget?"
"Show me how to use measureFactory.sum with useExecuteQuery"
"How do I add cross-filtering between dashboard widgets?"
"What's the difference between Dashboard and DashboardById?"
"How do I use filterFactory.dateRange to filter the last 30 days?"
"How do I customize the pivot table columns and styling?"
```

## Updating docs

When Sisense releases a new SDK version:

```bash
./scripts/update-docs.sh https://ai-playground-prod-2.vercel.app/rag_index/chunks.json
cd mcp-server && npm run build
```

## Complements the Sisense MCP Server

This works alongside the official [sisense-mcp-server](https://github.com/sisense/sisense-mcp-server):

- **Sisense MCP** — "What data sources and fields do I have?"
- **This MCP** — "How do I write the code to use that data with the Compose SDK?"

## Supported frameworks

- React
- Vue
- Angular
