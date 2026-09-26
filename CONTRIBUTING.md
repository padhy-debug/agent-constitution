# Contributing to Agent Constitution

We welcome contributions from developers, researchers, and AI practitioners worldwide! The goal of this repository is to build the universally recognized, battle-tested standard for autonomous coding agent discipline.

---

## 🌟 Areas Where We Need Your Help

1. **New Language & Stack Guides**:
   - Create guides under `docs/languages/` (e.g. C#, Swift, PHP/Laravel, Ruby on Rails, Elixir, Flutter/Dart).
   - Follow the established 4-part structure: Style & Tooling, Project Layout, Frameworks & Async, Testing & Security.
2. **Tool Adapters**:
   - New IDE adapters or extension integrations (e.g. Zed, Neovim LLM plugins, Emacs, Continue.dev).
3. **Agent Failure Post-Mortems (`case-studies/`)**:
   - Documented examples where an AI agent hallucinated, broke a production database, dropped prompt requirements, or caused an incident, and the exact rule that prevents it.
4. **CI & Automation Scripts**:
   - Enhancements to `scripts/install.sh`, `scripts/install.ps1`, or git hooks that enforce `CONTEXT.md` / `TASKS.md` freshness on commit.

---

## 📝 Guidelines for Pull Requests

- **High-Density & Token Efficient**: Documents in this repository are consumed by LLMs on every session. Avoid conversational filler, marketing fluff, or repetitive prose. Every sentence must provide concrete engineering utility.
- **Checklist & Machine-Readable Focus**: Format rules as clear imperatives, checklists, or tables.
- **Rooted in Failure Modes**: When proposing a new rule, explain the exact real-world agent defect it fixes (e.g. "Prevents agents from deleting untracked files on git checkout").
- **Attribution**: If your rule is inspired by a research paper, open-source project, or developer blog, please credit the source in [`ACKNOWLEDGEMENTS.md`](./ACKNOWLEDGEMENTS.md).

---

## 🚀 Development & Validation Workflow

1. Fork the repository and create a feature branch (`git checkout -b feature/swift-guidelines`).
2. Make your additions or updates.
3. Validate shell scripts and links:
   ```bash
   ./scripts/validate-constitution.sh
   ```
4. Commit your changes with a clear, descriptive message (`feat: add Swift and iOS development standards`).
5. Open a Pull Request using the [PR Template](./.github/PULL_REQUEST_TEMPLATE.md).

Thank you for helping build a safer, more capable future for autonomous coding agents!
