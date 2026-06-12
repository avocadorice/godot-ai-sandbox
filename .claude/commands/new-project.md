Walk the user through bootstrapping a new project. Ask these questions **one at a time**, waiting for each answer before proceeding:

1. **Project name** — will be used as the directory name and GitHub repo name (lowercase, hyphens ok)
2. **Goal** — one or two sentences: what is this project for?
3. **Tech stack / type** — e.g. "Python CLI", "Next.js web app", "data pipeline", "shell scripts", etc.
4. **GitHub repo?** — public, private, or skip

Once you have all answers, execute the bootstrap script:

```bash
bash ~/dev/claude-template/scripts/new-project.sh \
  "<project-name>" \
  "<goal>" \
  "<tech-stack>" \
  "<github: public|private|skip>"
```

After the script runs, confirm the new project directory and (if applicable) GitHub URL, then suggest the user `cd` into it and open Claude Code there.

Do not start writing any code or making plans until the user explicitly asks — this command is only for project setup.
