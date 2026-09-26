# Context Engineering & Memory Protocol

The core failure mode of autonomous coding agents is **session amnesia** and **context window pollution**:
1. Every new session re-derives the architecture from scratch, burning thousands of tokens.
2. Long conversations accumulate noisy compiler errors, test dumps, and intermediate thoughts, triggering the **"Lost-in-the-Middle" phenomenon** where the model forgets initial instructions.
3. Fixes made in past sessions are accidentally unmade or rediscovered.

This protocol defines how to maintain persistent, compact, high-density project memory.

---

## 1. The Context Hierarchy

```
┌────────────────────────────────────────────────────────┐
│  AGENTS.md                                             │  Master Behavioral Contract
│  (Static Rules, Unchanging Governance)                 │  Read every session (~2k tokens)
├────────────────────────────────────────────────────────┤
│  CONTEXT.md                                            │  Persistent Project State
│  (Tech Stack, Architecture, Decisions, Do-Not-Touch)   │  Updated after major changes (~1k tokens)
├────────────────────────────────────────────────────────┤
│  TASKS.md                                              │  Active Operational Ledger
│  (Numbered Plan, Status, Verification)                 │  Updated in real-time (~1k tokens)
├────────────────────────────────────────────────────────┤
│  Ephemeral Agent Context                               │  Working Memory
│  (Diffs, Test Outputs, Tool Calls)                     │  Cleared/compacted between tasks
└────────────────────────────────────────────────────────┘
```

---

## 2. File Specifications

### `CONTEXT.md` (Project State & Ground Truth)
Lives in the project root. Serves as the developer onboard memo:
- **Tech Stack & Tooling**: Languages, frameworks, key libraries, and the reason for choices.
- **Architecture Summary**: Component boundaries, data flow, and links to `docs/architecture-standards.md`.
- **Key Decisions Log (ADRs)**: Dated entries specifying what was chosen, why, and what was rejected.
- **Do-Not-Touch List**: High-risk, perf-tuned, or delicate workaround code with exact filenames and reasons.
- **Known Limitations & Technical Debt**: Explicit list of deferred items so agents do not mistakenly treat them as newly introduced bugs.

### `TASKS.md` (Operational Task Ledger)
Lives in the project root. Answers: *"What are we doing right now, what is done, and what is next?"*
- **Active Sprint / Milestone**: Numbered tasks with clear checkboxes (`[ ]` / `[x]`).
- **Implementation Approach & Trade-offs**: Chosen approach with brief pros/cons.
- **Completed History**: Reverse-chronological record of finished tasks with verification proof.
- **Backlog**: Deferred items kept out of current scope.

---

## 3. Context Compaction & Token Budgeting

Agents must actively practice **Token Hygiene**:

1. **Avoid Dumping Massive Files**:
   - Never read entire 2,000-line files into context if only modifying a 10-line function.
   - Use symbols, greps, or line-bounded reads (`offset` / `limit`).

2. **Compact Working Memory**:
   - Once a subtask passes its tests, do not keep repeating the intermediate failure logs in future prompts.
   - Record the outcome in `TASKS.md` and move forward with clean working context.

3. **High Density Over Verbose Prose**:
   - Bullet points beat multi-paragraph narrative essays.
   - State facts, line numbers, and metrics. Strip conversational filler.

---

## 4. The Session Wrap-up Ritual

Before terminating a session or handing off to another agent:

1. [ ] Did I make changes to architecture, dependencies, or key interfaces? → **Update `CONTEXT.md`**
2. [ ] Did I finish or progress any task? → **Update `TASKS.md`**
3. [ ] Did I discover a fragile code area that shouldn't be touched? → **Add to `CONTEXT.md`'s Do-Not-Touch list**
4. [ ] Did I leave any temporary files, logs, or uncommitted scratchpad files? → **Clean them up**
