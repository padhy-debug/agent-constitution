# Subagent & Multi-Agent Orchestration Protocol

> **Core Principle**: Large, complex tasks collapse under monolithic agent context. Decompose work across specialized roles with strict context boundaries.

---

## 1. Why Orchestration Matters

When a single agent context attempts to:
1. Brainstorm architecture
2. Write hundreds of lines of code
3. Run tests and debug failures
4. Perform security audits

...the context window fills up with noisy compiler errors and logs. This triggers **context degradation**, **hallucination**, and **forgetting early constraints**.

Multi-agent / subagent architectures prevent this by maintaining **clean context separation**.

---

## 2. The 3-Role Orchestration Model

```mermaid
graph TD
    User([User Request]) --> Architect[Architect / Planner]
    Architect --> |Phase Plan & Spec| Builder[Builder / Implementer]
    Builder --> |Diff & Test Results| Auditor[Auditor / Reviewer]
    Auditor --> |Feedback / Rejection| Builder
    Auditor --> |Verification Passed| Output([Verified Delivery])
```

### Role 1: The Architect (Planner)
- **Responsibility**: Scopes the problem, reads context files (`CONTEXT.md`, `TASKS.md`, architecture docs), designs interfaces, and writes a detailed implementation plan.
- **Constraints**: Does not edit implementation code. Focuses on requirements completeness and threat modeling.
- **Output**: Structured task breakdown with pros/cons and acceptance criteria (see template: [`templates/PHASE_PLAN.md`](../templates/PHASE_PLAN.md)).

### Role 2: The Builder (Implementer)
- **Responsibility**: Takes a single, well-defined task from the plan and implements it using TDD.
- **Constraints**: Strict non-regression policy. Does not expand scope or touch files outside the assigned blast radius.
- **Output**: Working code diff and passing test results.

### Role 3: The Auditor (Reality Checker & Security)
- **Responsibility**: Rigorous, adversarial review. Checks for:
  - Did the Builder fulfill ALL acceptance criteria or silently drop some?
  - Are there security holes (OWASP Top 10, injection, auth bypass)?
  - Are there regressions or untested branches?
  - Does the implementation meet senior coding standards?
- **Constraints**: Uncompromising. Rejects sloppy code or unverified claims.
- **Output**: Formal audit verification and sign-off report (see template: [`templates/AUDIT_REPORT.md`](../templates/AUDIT_REPORT.md)).

---

## 3. Subagent Handoff Rules

When delegating to or switching between subagents:

1. **Provide Clear Context Bundles**: Pass only relevant files and interfaces using the standardized handoff schema (see template: [`templates/HANDOFF.md`](../templates/HANDOFF.md)). Never dump raw unbounded conversation history.
2. **Deterministic Completion Criteria**: Every subagent invocation must have a clear stopping condition (e.g. "Run `npm test` until all 4 tests in `auth.test.ts` pass, then report").
3. **No Unmanaged Background Loops**: Subagents must not poll endlessly or spin up unbounded loops.
4. **Synthesize Findings**: The orchestrator must compile subagent reports into concise, actionable summaries for the user.

---

## 4. Multi-Agent Swarm Concurrency & State Invariants

In high-concurrency environments where multiple agents or subagents operate in parallel:

### 1. Atomic Task Claiming Protocol
- When multiple Builders run concurrently, they must never write to the same task or file without mutual exclusion.
- **The Protocol**:
  1. An agent must mark a task in `TASKS.md` as `[IN_PROGRESS: <agent-id>]` before modifying any files.
  2. If a task is already marked `IN_PROGRESS`, another agent must select the next unclaimed task or block until handoff.
  3. Parallel agents must work in dedicated Git worktrees or isolated feature branches (`feat/<agent-id>-<task>`) to eliminate merge conflicts.

### 2. Zero-Trust Auditor Context (Anti-Sycophancy)
- **The Trap**: Passing the Builder's conversational reasoning to the Auditor induces confirmation bias. The Auditor rationalizes shortcuts taken by the Builder.
- **The Rule**: The Auditor receives ONLY:
  1. The initial task specification and acceptance criteria.
  2. The raw git diff (`git diff HEAD~1`).
  3. The test execution logs and coverage reports.
  4. The Auditor must NEVER receive the Builder's conversational explanations or apologies.

### 3. State Merging Serialization
- Only the **Session Orchestrator** or **Lead Architect** may merge completed branch diffs and update `CONTEXT.md` Session Logs. Builders never update root persistent context directly during parallel execution.
