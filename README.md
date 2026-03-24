# CSDK Docs — Claude Code Skill + MCP Server

Claude Code slash commands and an MCP server that give Claude access to the full Sisense Compose SDK documentation for accurate, context-aware answers.

## Two ways to use it

| Method | How it works | Best for |
|--------|-------------|----------|
| **Slash commands** | Claude reads index files, picks relevant docs | Quick questions, browsing docs |
| **MCP server** | TF-IDF search returns the most relevant chunks automatically | Precise lookups, code-aware search |

## Install

```bash
git clone https://github.com/pmorris24/csdk-docs-skill.git
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

```
/csdk-quick what props does useExecuteQuery accept?
```

```
/csdk-react how do I embed a dashboard with custom filters?
```

With the MCP server, Claude will automatically use `search_csdk_docs` when it needs SDK documentation — no slash command needed.

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
