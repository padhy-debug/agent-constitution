# Git & GitHub Push Guardrails Protocol

> **Core Objective**: Prevent AI coding agents from polluting remote repositories, spamming commit histories, pushing unverified code, or altering protected branches.

---

## 1. The Hard Lockout on Autonomous Remote Push

Autonomous coding agents frequently make the mistake of eagerly running `git push` after small, unverified changes. This breaks CI pipelines, triggers unwanted production deployments, and pollutes remote branch histories.

### Absolute Push Mandate:
- **`git push` is LOCKED BY DEFAULT**: An agent must **NEVER** autonomously execute `git push`, `git push origin`, or any push variant without **explicit user authorization in the current conversation turn**.
- **Explicit Instruction Required**: Only when the user explicitly commands *"push this"*, *"push to GitHub"*, or *"create and push a PR branch"* is the agent authorized to contact the remote repository.
- **Strict Prohibition on Force Push**: `git push --force` or `git push -f` is **STRICTLY BLACKLISTED**. Zero exceptions under any circumstance.

---

## 2. Protected Branch Lockout

- **Never Commit or Push Directly to Primary Branches**:
  - `main`, `master`, `production`, `release`, and `stable` are protected branches.
  - Agents must **NEVER** push commits directly to these branches.
- **Feature Branch Isolation**:
  - All work must be conducted on isolated, descriptive branches:
    - `feat/<task-name>`: New additive capability
    - `fix/<issue-name>`: Bug repair
    - `refactor/<target>`: Scope-contained refactoring
    - `docs/<subject>`: Documentation updates
- **Pull Request (PR) Workflow**:
  - Work must be integrated into primary branches exclusively through verified Pull Requests with clean review notes.

---

## 3. The 4-Point Pre-Commit & Pre-Push Tripwire

Before creating a commit or requesting to push, the agent must verify all 4 gates with exit code 0:

```
┌────────────────────────────────────────────────────────┐
│ Gate 1: Working Tree Cleanliness                       │
│ - Check `git status`                                   │
│ - Zero accidental artifacts, scratch files, or temp logs│
├────────────────────────────────────────────────────────┤
│ Gate 2: Test Suite Exit Code 0                         │
│ - Run local compiler, build runner, and test suite     │
│ - Zero failing unit or integration tests               │
├────────────────────────────────────────────────────────┤
│ Gate 3: Linter & Format Verification                   │
│ - Run local static analysis tool                       │
│ - Zero lint errors or foreign formatting changes       │
├────────────────────────────────────────────────────────┤
│ Gate 4: Zero Secret or PII Leakage                     │
│ - Scan diff for API keys, bearer tokens, passwords,    │
│   internal URLs, or private customer data              │
└────────────────────────────────────────────────────────┘
```

---

## 4. Atomic Commits & Conventional Standards

Spamming git history with messages like *"fix bug"*, *"update"*, or *"wip"* is forbidden.

### Commit Rules:
1. **Conventional Commits**: Format commit messages according to the Conventional Commits specification:
   ```
   <type>(<scope>): <concise description in imperative mood>

   [optional body explaining motivation and blast radius]
   ```
   - Standard types: `feat`, `fix`, `refactor`, `perf`, `test`, `docs`, `chore`.
2. **Atomic Units**: One logical change per commit. Never bundle bug fixes with unrelated formatting changes or configuration tweaks.
3. **No Drive-By Commits**: Only stage files that were intentionally modified for the current task (`git add <specific-files>`). Never run indiscriminate `git add .` or `git add -A` without inspecting the staged diff first.
