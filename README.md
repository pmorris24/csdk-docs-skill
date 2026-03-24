# CSDK Docs — Claude Code Skill

A Claude Code slash command that gives Claude access to the full Sisense Compose SDK documentation for accurate, context-aware answers.

## Install

Clone this repo, then use Claude Code from within it:

```bash
git clone https://github.com/YOUR_USERNAME/csdk-docs-skill.git
cd csdk-docs-skill
claude
```

Or add it to an existing project as a submodule:

```bash
git submodule add https://github.com/YOUR_USERNAME/csdk-docs-skill.git .csdk-docs
```

Then copy the command into your project:

```bash
mkdir -p .claude/commands
cp .csdk-docs/.claude/commands/csdk-docs.md .claude/commands/
```

## Usage

In Claude Code, type:

```
/csdk-docs how do I create a bar chart with filters?
```

```
/csdk-docs what props does DashboardById accept?
```

```
/csdk-docs how do I use useExecuteQuery with measures and dimensions?
```

## What's included

- `/docs` — Full Sisense Compose SDK documentation (API references, guides, examples)
- `/.claude/commands/csdk-docs.md` — The slash command that reads the docs and answers questions

## Supported frameworks

- React
- Vue
- Angular

Specify the framework in your question, or it defaults to React.
