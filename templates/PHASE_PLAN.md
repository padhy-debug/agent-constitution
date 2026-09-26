# Phase Implementation Plan (Architect Output)

> Produced by the Architect role before any implementation code is written.
> See `docs/subagent-orchestration.md` and `docs/agent-decision-matrix.md`.

---

## 1. Intent & Problem Statement

- **Task Title**: [Concise technical summary]
- **Root Cause / Motivation**: [Why this change is needed]
- **Target Tier**: [Tier 1: Surgical Fix | Tier 2: Additive Feature | Tier 3: Architectural Migration]

---

## 2. Scope Containment

- **Positive Scope (What will be modified/created)**:
  - `file1.ext` (lines X-Y)
  - `file2.test.ext`
- **Negative Scope (What must NOT be touched)**:
  - Any files listed on `CONTEXT.md` Do-Not-Touch list
  - Adjacent functions in modified files

---

## 3. Blast Radius & Caller Impact

| Affected Component | Caller / Consumer | Breaking Risk (Low/Med/High) | Mitigation |
|---|---|---|---|
| `functionA()` | `router.ts:88` | Low | Preserved backward-compatible signature |

---

## 4. TDD Verification Strategy

1. **Failing Test (Red)**:
   - File: `tests/...`
   - Assertion: [Exact behavior being proven]
   - Expected error output: [Exact expected failure message]
2. **Implementation (Green)**:
   - Minimal code change to satisfy test.
3. **Refactor & Linter Check**:
   - Native project linter command.

---

## 5. Sequential Execution Steps

- [ ] Step 1: Write reproducing unit test. Run test to verify failure (exit code != 0).
- [ ] Step 2: Implement minimal viable diff in target file.
- [ ] Step 3: Run test suite to verify passage (exit code 0).
- [ ] Step 4: Run full project test suite to verify zero blast-radius regressions.
- [ ] Step 5: Update `CONTEXT.md` Session Log and `TASKS.md`.
