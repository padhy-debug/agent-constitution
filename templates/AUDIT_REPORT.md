# Code & Security Audit Report (Auditor Output)

> Produced by the Auditor role following Builder implementation.
> Rigorous verification before merge or completion. See `docs/subagent-orchestration.md` and `docs/security-and-depth.md`.

---

## 1. Audit Metadata

- **Review Target**: [PR #, Branch, or Task ID]
- **Auditor**: [AI Auditor Role / Reviewer]
- **Verdict**: [APPROVED | REJECTED — REWORK REQUIRED]

---

## 2. Constitutional Compliance Checklist

- [ ] **Surgical Scope**: Diff contains only required changes (no unrequested adjacent formatting or drive-by refactors).
- [ ] **Minimal Viable Diff (MVD)**: Lines touched <= strictly necessary.
- [ ] **TDD Tripwire**: Automated test exists, reproduces the condition, and passes.
- [ ] **Blast Radius Safe**: Downstream callers checked; zero regressions in existing test suite.
- [ ] **Context Memory**: `CONTEXT.md` Session Log and `TASKS.md` updated accurately.

---

## 3. Adversarial Security Review (OWASP & ASVS)

| Security Surface | Risk Level | Findings / Code Reference | Mitigated? (Yes/No) |
|---|---|---|---|
| Injection (SQL/Command/Eval) | None/Low/High | | |
| Auth & Access Control (IDOR/BOLA) | None/Low/High | | |
| Data Exposure & Secrets | None/Low/High | | |
| Input Validation & Boundary Checks| None/Low/High | | |
| Rate Limiting & Resource Exhaustion| None/Low/High| | |

---

## 4. Verification Evidence (Proof of Work)

- **Test Command**:
  ```bash
  [command executed]
  ```
- **Output Snippet**:
  ```
  [Raw terminal output proving exit code 0]
  ```
- **Linter / Typecheck Command**:
  ```bash
  [linter command executed]
  ```

---

## 5. Auditor Recommendations & Action Items

- **Blockers (Must fix before approval)**:
  - None (or listed here)
- **Non-blocking Observations (Log in `TASKS.md` Backlog)**:
  - Optional optimization or clean-up notes.
