---
name: Agent Failure / Rogue Behavior Report
about: Report a failure mode where an agent broke rules, hallucinated, or caused a regression
title: "[Agent Incident]: "
labels: ["incident", "triage"]
assignees: ''
---

## Agent Environment
- **Agent / Tool Used**: (e.g. Cursor, Claude Code, Windsurf, Copilot, Cline, Aider)
- **Model**: (e.g. Claude 3.5 Sonnet, GPT-4o, Gemini 1.5 Pro)
- **Project Stack**: (e.g. TypeScript / Next.js, Python / FastAPI, Go)

## What Happened?
Describe the incident. What task did you ask the agent to perform, and what did it actually do?

## What Rule Was Violated or Missing?
Which section of `AGENTS.md` or `docs/` was ignored, or what new rule would have prevented this?

## Suggested Constitution Fix
How should we amend the rules or checklists to prevent this failure pattern forever?
