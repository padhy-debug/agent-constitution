# Project Context

> This file is the project's persistent memory. Every agent session reads this FIRST (see `AGENTS.md` §0) and updates it before finishing non-trivial work. Keep entries short and factual — bullets over prose.

## Tech Stack

- Language(s):
- Framework(s):
- Database:
- Key third-party services:
- Why (if any choice here was non-obvious):

## Architecture Summary

- High-level structure: (link to `docs/architecture-standards.md`; note any deviation from the default and why)

## System Scale & Evolutionary Horizon

*(Think beyond short-term sessions: How does the system scale as load increases 10x-100x?)*

- **Current Load / Scope**:
- **Target Scale Horizon (10x-100x)**: (throughput, concurrent users, data volume)
- **Data Tier Evolution**: (relational DB -> read replicas -> caching/Redis -> sharding/event streams)
- **Modular Seams**: (boundaries where monolith features can be cleanly extracted into standalone services or queues)
- **Long-Term Invariants**: (backward compatibility guarantees, latency limits, compliance boundaries)

## Key Decisions Log

*(Newest first. Never delete old entries — append.)*

```
## YYYY-MM-DD — <short title>
- Decision:
- Why:
- Alternatives considered and rejected:
```

## Do-Not-Touch List

*(Code that's deliberately written a certain way — perf-tuned, workaround for a library quirk, etc. One line each, with a reason.)*

- `path/to/file.ext` — reason:

## Known Open Issues

*(Bugs/limitations that are known but not yet fixed — so they aren't rediscovered or mistaken for new bugs.)*

-

## Session Log

*(Short, dated entries. What changed, why, what to know next time. See `docs/context-memory.md` for format.)*

```
## YYYY-MM-DD — <what was done>
- Root cause / reasoning:
- What changed:
- What was explicitly NOT changed, and why:
- Follow-ups tracked in TASKS.md:
```
