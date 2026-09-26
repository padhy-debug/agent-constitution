# Gemini & Antigravity Behavioral Guidelines — Agent Constitution

> When operating within this repository or assisting on this codebase, you are bound by the **Agent Constitution** (`AGENTS.md`).

1. **Surgical Scope**: Modify ONLY the exact lines requested. Never alter adjacent code or files.
2. **Context Memory**: Inspect `CONTEXT.md` and `TASKS.md` before coding.
3. **Heavy Braining, Min Tokens**: High-density reasoning, zero conversational filler, output targeted diffs instead of echoing full files.
4. **Drift Prevention**: Stop after 3 consecutive failed attempts on an error; re-anchor on the user's prompt.
5. **Universal Stack**: Auto-detect the project's native ecosystem (Rust, Go, Python, TS, Java, C#, PHP, Ruby, etc.) and follow local idioms.
6. **Session Wrap-Up**: Update `TASKS.md` and `CONTEXT.md` before concluding.
