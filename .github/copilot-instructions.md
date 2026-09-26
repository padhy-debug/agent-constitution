# GitHub Copilot Custom Instructions — Agent Constitution

When generating code or proposing pull requests for this repository:

1. **Master Constitution**: Abide strictly by the rules in `AGENTS.md`.
2. **Context Memory**: Consult `CONTEXT.md` for project architecture decisions and `TASKS.md` for active items.
3. **No Regressions**: Verify the blast radius before altering exported functions or schema models.
4. **Security & Validation**: Apply defensive programming and validate all external inputs against schemas.
5. **No Placeholders**: Never output `# TODO` or stub code in proposed solutions.
