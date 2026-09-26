# Incident & Regressions Post-Mortem

## Incident Summary
- **Date**: YYYY-MM-DD
- **Severity**: [P1 - Critical | P2 - Major | P3 - Moderate | P4 - Low]
- **Impact**: What broke? Who was affected? How long was it broken?
- **Root Cause**: What underlying defect or assumption caused the failure?

---

## 5 Whys Analysis
1. *Why did the failure occur?*
2. *Why did that happen?*
3. *Why was it not caught earlier?*
4. *Why did the test suite or verification step miss it?*
5. *Why was the rule or guardrail insufficient?*

---

## Corrective Actions & Constitution Updates
- [ ] **Immediate Fix**: (Commit hash / PR link)
- [ ] **Regression Test Added**: (Path to test file ensuring this can never recur silently)
- [ ] **Rule / Constitution Update**: (What rule in `AGENTS.md` or `docs/` was added/strengthened)
- [ ] **Do-Not-Touch Entry**: (Added to `CONTEXT.md` to protect this pattern)
