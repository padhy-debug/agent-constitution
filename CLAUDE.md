# Claude Code Project Guidelines — Agent Constitution

> ⚠️ **MANDATORY CONTRACT**: Abide strictly by the rules in `AGENTS.md` and check project status in `CONTEXT.md` and `TASKS.md`.

## Core Directives for Claude Code:
1. **Surgical Precision**: Touch ONLY lines required for the active task. Never touch, "clean up", or refactor neighboring functions or files.
2. **Heavy Braining, Min Tokens**: Deliver dense technical facts. Never echo back full unchanged files; output concise diffs only.
3. **Drift & Circuit Breakers**: Stop and report if an edit or test fails 3 consecutive times.
4. **Universal Stack**: Auto-detect language, linter, and build tools from repository manifests.
5. **Session Wrap-Up**: Update `TASKS.md` and `CONTEXT.md` before concluding.
