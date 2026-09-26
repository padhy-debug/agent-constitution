# GitHub Copilot Custom Instructions — Agent Constitution

When generating code or proposing pull requests for this repository:

1. **Surgical Scope**: Touch ONLY the exact lines needed for the requested task. Do NOT refactor or reformat adjacent code or files.
2. **Context Memory**: Consult `CONTEXT.md` for project architecture decisions and `TASKS.md` for active items.
3. **Heavy Braining, Min Tokens**: Deliver concise, dense solutions. Do not echo full unchanged files.
4. **Universal Stack**: Follow the project's native idioms and linters discovered in manifest files.
5. **Zero Regressions**: Verify the blast radius before altering exported functions or schema models.
6. **No Placeholders**: Never output `# TODO` or stub code in proposed solutions.
