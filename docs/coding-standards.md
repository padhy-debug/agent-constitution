# Senior Coding Standards & Craftsmanship

What "senior-engineer-grade code" means in practice, regardless of language or framework.

---

## 1. Absolute Non-Negotiables

- **No Placeholder Code**: Never leave `# TODO: implement later`, `// fixme`, or `throw new Error("stub")` in production code. If a feature is deferred, track it explicitly in `TASKS.md` and communicate it clearly.
- **Zero Silent Failures**: Every error must be handled intentionally. Never swallow exceptions with empty catch blocks (`catch (e) {}` or `except: pass`). Either handle, log with context, retry, or rethrow.
- **No Dead Code**: Do not leave commented-out blocks or unused imports. Git stores history.
- **Explicit Input Validation**: Validate every input crossing a network, filesystem, or process boundary before executing business logic.
- **Strict Typing**: Use strict typing options across TypeScript, Python (mypy/pyright), Go, and Rust. Avoid escape hatches like `any`, `Object`, or untyped dictionaries when structured types can be defined.

---

## 2. Defensive Programming & Error Ergonomics

- **Fail Fast**: Check preconditions at the beginning of functions (guard clauses). Return early to eliminate nested `if/else` ladders.
- **Contextual Errors**: When bubbling errors up, attach domain context:
  - Bad: `Error: Connection failed`
  - Good: `Failed to load billing history for customer ID 'cust_123' from Stripe: Connection timed out`
- **Idempotency**: Strive to make mutating operations idempotent whenever feasible, especially for webhooks, retries, and background jobs.

---

## 3. High-Quality Naming

- **Intention-Revealing**: Names must answer *why it exists*, *what it does*, and *how it is used*.
  - Bad: `const data = ...`, `function handleThings()`, `let flag = false`
  - Good: `const activeSubscribers = ...`, `function dispatchOrderFulfillment()`, `let isRateLimitExceeded = false`
- **Avoid Misleading Names**: Do not append `List` to a variable unless it is actually a list (e.g. `userList` when it is a `Set` or `Map`).
- **Pronounceable & Searchable**: Avoid cryptic abbreviations (`genSubLgc()` → `generateSubscriptionLogic()`).

---

## 4. Self-Review Checklist (Run Before Presenting Diff)

Before an agent considers its code ready for the user, it must evaluate:

1. [ ] **Happy Path & Edge Cases**: Did I handle null, empty arrays, zero, negative numbers, and timeout conditions?
2. [ ] **No Hidden Regressions**: Did I verify that callers of this function still receive the expected types and responses?
3. [ ] **Consistency**: Does this match the existing conventions and style of the surrounding codebase?
4. [ ] **Performance**: Are there unindexed queries, N+1 loops, memory leaks, or unclosed file handles?
5. [ ] **Documentation**: Do non-obvious algorithms have concise comments explaining the *why*?
