Answer the following question about the Sisense Compose SDK using the documentation in this project.

## Instructions

1. Determine the framework from the question or project context. Default to React if unclear. Use `fw` = react, vue, or angular.

2. **Start by reading the indexes** to decide which files are relevant:
   - `docs/{fw}/INDEX.md` — lists all API and interface files for the framework
   - `docs/guides/INDEX.md` — lists all guide topics

3. Based on the question, read ONLY the relevant files — never read everything:

   **Framework API** (`docs/{fw}/`):
   - `charts.md` — Chart components
   - `dashboards.md` — Dashboard and widget components, hooks
   - `contexts.md` — Context providers and configuration
   - `chart-interfaces.md` — Chart style options and props
   - `dashboard-interfaces.md` — Dashboard/widget types
   - `filter-interfaces.md` — Filter types
   - `theme-interfaces.md` — Theme settings
   - `data-interfaces.md` — Data options types
   - `ai-interfaces.md` — NLG, NLQ, Chatbot types
   - `interaction-interfaces.md` — Drilldown, selection types
   - `other-interfaces.md` — Everything else

   **Data API** (`docs/data/`):
   - `factories.md` — filterFactory, measureFactory, analyticsFactory
   - `functions.md` — Individual function reference

   **Guides** (`docs/guides/`) — pick by topic from the index.

   **Design/UX**:
   - `docs/csdk_chart_design.md`, `docs/csdk_ui_ux_skill.md`, `docs/csdk_supplemental.md`

4. Provide accurate answers with code examples from the docs.
5. If the answer isn't in the docs, say so.

**Tip:** For faster results, use `/csdk-react`, `/csdk-vue`, or `/csdk-angular` directly.
For quick lookups, use `/csdk-quick`.

## Question

$ARGUMENTS
