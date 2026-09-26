# Context Handoff Bundle

> Protocol for transferring state between AI subagent roles (Architect ➔ Builder ➔ Auditor).
> See `docs/subagent-orchestration.md` for full orchestration guidelines.

---

## 1. Transmission Metadata

- **From Role**: [Architect | Builder | Auditor]
- **To Role**: [Architect | Builder | Auditor]
- **Session / Task ID**: [e.g., TASK-042]
- **Timestamp**: [YYYY-MM-DD HH:MM:SS]

---

## 2. Objective & Scope

- **Primary Goal**: [One clear sentence describing what needs to be done]
- **In-Scope Files**:
  - `path/to/target1.ext`
  - `path/to/target2.ext`
- **Out-of-Scope Files (Negative Scope)**:
  - `path/to/do-not-touch.ext`

---

## 3. Ground Truth & Evidence

- **Relevant Interfaces / Functions**:
  - `src/services/auth.ts:45-80`
- **Current Test Status**: [Passing | Failing (Red) | Not Yet Written]
- **Reproduction / Verification Command**:
  ```bash
  npm test tests/auth.test.ts
  ```

---

## 4. Key Constraints & Guardrails

- **Blast Radius**: [Target callers or downstream dependents]
- **Performance / Security Invariants**: [e.g., Zero allocations in hot loop, OWASP ASVS checks]
- **Token Economy Guideline**: Do not re-examine untouched directories; focus exclusively on in-scope files.

---

## 5. Acceptance & Stopping Criteria

- [ ] Requirement 1: [Specific, verifiable criterion]
- [ ] Requirement 2: [Specific, verifiable criterion]
- [ ] Verification command exits with code 0.
- [ ] Minimal Viable Diff (MVD) verified: zero drive-by changes to adjacent lines.
