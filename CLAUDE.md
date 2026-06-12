# claude-template

This is the base template for all Claude Code projects.

## What's included

- **Auto-logging hooks** — every prompt and Claude's final response are appended to `logs/session.log` automatically.
- **`/new-project` command** — type `/new-project` inside Claude Code to interactively bootstrap a new project (name, goal, stack, GitHub).

## Starting a new project

```
/new-project
```

Claude will ask you a few questions, then run `scripts/new-project.sh` to create a new directory under `~/dev/`, copy this template, write a project-specific `CLAUDE.md`, init git, and optionally create a GitHub repo.

## Session log

`logs/session.log` is updated automatically via hooks:
- **UserPromptSubmit** → logs your prompt
- **Stop** → captures the last response (up to 600 chars) and appends `---`

Use this to review what was discussed across sessions without re-reading full transcripts.

## Updating the template

Make changes here in `~/dev/claude-template`. New projects cloned after the change will pick them up. Existing projects won't auto-update (by design).
