# 🧠 Agent Constitution

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](./CONTRIBUTING.md)
[![CI Status](https://img.shields.io/badge/CI-Passing-brightgreen.svg)](./.github/workflows/ci.yml)
[![Universal Models](https://img.shields.io/badge/Models-Claude%20%7C%20GPT--4o%20%7C%20Gemini%20%7C%20DeepSeek%20%7C%20Qwen-blueviolet.svg)](#-universal-model--stack-agnostic)
[![Universal Tools](https://img.shields.io/badge/Tools-Cursor%20%7C%20Claude%20Code%20%7C%20Windsurf%20%7C%20Cline%20%7C%20Copilot%20%7C%20Aider-blue.svg)](#-universal-tool-adapters)

**The Universal Behavioral Contract & Context Engine that turns any AI coding agent into a disciplined senior engineer — eliminating cascading regressions, hallucinated tangents, and token-burning loops.**

[Quick Start](#-quick-start) • [The Core Problem](#-the-reality-of-ai-coding-today) • [Surgical Scope](#1-surgical-editing--the-anti-cascade-law) • [The 13 Pillars](#-the-constitutional-pillars) • [Tool Compatibility](#-universal-tool-adapters) • [Acknowledgements](#-acknowledgements--credits)

</div>

---

## ⚡ The Reality of AI Coding Today

Left to their default behaviors, AI coding agents across all major models exhibit predictable, frustrating failure modes:

| ❌ Default Agent Behavior (Chaos) | ✅ With Agent Constitution (Order) |
|---|---|
| **Cascading Breakages (1 fix breaks 3 things)**: Fixes a small bug, but "helpfully" refactors adjacent code, breaking untested callers. | **Surgical Scope & Quarantine**: Forbidden from touching adjacent code. Minimal Viable Diff (MVD) only. |
| **Context Vomit & Agent Drift**: Wanders into lengthy tutorial prose, guesses irrelevant causes, or loops on errors. | **Anti-Drift & 3-Strike Circuit Breaker**: Mandates hard stop after 3 failed attempts; re-anchors directly on original prompt. |
| **Token Waste & Echoing**: Burns 100k tokens dumping 500 lines of unchanged code back into the chat. | **Heavy Braining, Min Tokens**: Maximum cognitive reasoning delivered in compact, high-density diffs. Zero fluff. |
| **Single-Language Bias**: Treats every repo like a toy Python or JS script, ignoring project idioms. | **Universal Stack Auto-Detection**: Fingerprints any stack (Rust, Go, C#, C++, Java, PHP, Ruby, Swift, Elixir, IaC). |
| **Session Amnesia**: Every new chat starts from zero, re-discovering the codebase from scratch. | **Persistent Memory (`CONTEXT.md` / `TASKS.md`)**: Maintains lightweight project state across sessions and models. |
| **Sycophantic "Yes-Man"**: Nods along with bad architecture and skims only the single line you pointed at. | **Anti-Sycophancy & Adversarial Security**: Conducts rigorous OWASP and edge-case audits without flattery. |
| **Hallucinates APIs & Dependencies**: Guesses libraries, files, and signatures that don't exist. | **Evidence-First Verification**: Forbidden from asserting facts without inspecting code and raw terminal proof. |
| **Catastrophic Commands**: Drops tables, runs `git reset --hard` on uncommitted files, or leaks secrets. | **Zero-Data-Loss Guardrails**: Immediate stop-and-verify lockout on destructive commands. |

---

## 🚀 Quick Start

### Option 1: NPX (Recommended — Zero Install, Universal)

Run inside your project's root directory:

```bash
npx agent-constitution init
```
*To activate deterministic git hooks (pre-commit & pre-push guardrails):*
```bash
npx agent-constitution hooks
```
*To launch the zero-dependency Model Context Protocol (MCP) Brahmastra Server:*
```bash
npx agent-constitution mcp
```
*To diagnose repository health and AI readiness:*
```bash
npx agent-constitution doctor
```
*To inspect the active git diff for placeholders, leaks, and blast radius:*
```bash
npx agent-constitution diff-guard
```
*To run the 100% empirical benchmark evaluation:*
```bash
npx agent-constitution benchmark
```

### Option 2: One-Line Curl / PowerShell Installer

**Linux / macOS:**
```bash
curl -fsSL https://raw.githubusercontent.com/padhy-debug/agent-constitution/main/scripts/install.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/padhy-debug/agent-constitution/main/scripts/install.ps1 | iex
```

*Or install locally from a cloned repository:*
```bash
# Linux / macOS
./scripts/install.sh /path/to/target-project

# Windows (PowerShell)
.\scripts\install.ps1 -TargetDir C:\path\to\target-project
```

### Option 3: Manual Drop-In

1. Copy [`AGENTS.md`](./AGENTS.md), [`docs/`](./docs/), and [`templates/`](./templates/) into your project root.
2. Initialize memory files:
   ```bash
   cp templates/CONTEXT.md CONTEXT.md
   cp templates/TASKS.md TASKS.md
   ```
3. Copy the adapter matching your tool (e.g., `CLAUDE.md`, `.cursorrules`, `.windsurfrules`, `.clinerules`, or `.github/copilot-instructions.md`).
4. Point your agent at `AGENTS.md` and enjoy disciplined engineering!

### 🛡️ Verify Compliance Anytime

Run the validation suite to ensure your repository has zero drift and complete contract coverage:

```bash
# Linux / macOS
./scripts/validate-constitution.sh

# Windows (PowerShell)
.\scripts\validate-constitution.ps1
```

---

## 🏛️ The Constitutional Pillars

```mermaid
graph TD
    A[Master Contract AGENTS.md] --> B[1. Surgical Scope & Zero Cascades]
    A --> C[2. Anti-Drift & Circuit Breakers]
    A --> D[3. Token Economics & Heavy Braining]
    A --> E[4. Universal Stack Auto-Detection]
    A --> F[5. Anti-Hallucination & Evidence]
    A --> G[6. Blast Radius & Non-Regression]
    A --> H[7. Agent Test-Driven Development TDD]
    A --> I[8. Safe Execution & Zero Data Loss]
    A --> J[9. Remote Git Push Lockout]
    A --> K[10. Anti-AI-Slop Aesthetics]
    A --> L[11. Monorepos & Multi-Package Governance]
    A --> M[12. Brahmastra MCP & Agent Plugins]
    A --> N[13. Limitless Agency & 100-Year Horizon]
```

### 1. Surgical Editing & The Anti-Cascade Law
*(Full detail: [`docs/surgical-editing-and-scope-containment.md`](./docs/surgical-editing-and-scope-containment.md))*
- **The #1 Problem**: AI agents love doing "drive-by refactoring" — fixing a bug while "helpfully" cleaning up neighboring code or changing shared signatures. This causes 1 fix to spawn 3 new bugs.
- **The Constitutional Rule**: The agent is bound to the **Minimal Viable Diff (MVD)**. It is forbidden from touching, refactoring, or reformatting adjacent code. If it discovers another issue nearby, it must quarantine it in `TASKS.md` — never touch it autonomously.

### 2. Agent Drift Prevention & 3-Strike Circuit Breakers
*(Full detail: [`docs/drift-prevention-and-circuit-breakers.md`](./docs/drift-prevention-and-circuit-breakers.md))*
- Stops agents from getting lost in conversational rabbit holes, dumping massive error logs, or thrashing code in infinite loops.
- **3-Strike Rule**: If an edit fails 3 consecutive times, the agent must **HARD STOP**, summarize the blocker, and ask for guidance.

### 3. Token Economics & Heavy Braining (Max Output, Min Tokens)
*(Full detail: [`docs/token-economy-and-max-output.md`](./docs/token-economy-and-max-output.md))*
- Maximum cognitive depth (Heavy Braining) paired with extreme token discipline.
- **Zero Fluff**: No conversational pleasantries.
- **No Echoing**: Never dump 400 lines of unchanged code back to the user; output targeted diffs only.
- **Line-Bounded Tool Calls**: Inspect targeted line ranges instead of loading massive files into context.

### 4. Universal Stack Auto-Detection
*(Full detail: [`docs/universal-stack-detection.md`](./docs/universal-stack-detection.md))*
- Stack-agnostic engineering that works for **any language**: Rust, Go, Python, TypeScript/JS, C#, C++, Java, Kotlin, PHP, Ruby, Elixir, Swift, Dart, Shell, SQL, Terraform, etc.
- Dynamically discovers and respects local repository manifests and linters (`.editorconfig`, `ruff.toml`, `.golangci.yml`, `phpcs.xml`, `clippy`, etc.).

### 5. Anti-Hallucination & Epistemic Modesty
*(Full detail: [`docs/anti-hallucination-evidence.md`](./docs/anti-hallucination-evidence.md))*
- Never claim an API, file, or function behaves in a certain way without inspecting it directly in the current session. Cite exact file paths and line numbers.

### 6. Blast Radius & Non-Regression Policy
*(Full detail: [`docs/non-regression-policy.md`](./docs/non-regression-policy.md))*
- Search all callers, protect the Do-Not-Touch list, and verify tests pass with exit code 0 before concluding.

### 7. Test-Driven Development (TDD) for Agents
*(Full detail: [`docs/tdd-and-verification.md`](./docs/tdd-and-verification.md))*
- Red-Green-Refactor agent cycle. Agents with automated test feedback loops produce 80% fewer hallucinations.

### 8. Safe Execution & Zero Data Loss
*(Full detail: [`docs/safe-execution-guardrails.md`](./docs/safe-execution-guardrails.md))*
- Hard lockout on destructive commands (`DROP TABLE`, `rm -rf /`, `git reset --hard` on dirty trees, `git push --force`).

### 9. Remote Git Push Lockout & Branch Protection
*(Full detail: [`docs/git-and-github-push-guardrails.md`](./docs/git-and-github-push-guardrails.md))*
- `git push` is locked by default. Autonomous agents must never push code to remote repositories without explicit user instruction. Zero direct commits or pushes to `main`/`master`.

### 10. Modern Frontend Aesthetics & Anti-AI-Slop
*(Full detail: [`docs/frontend-design-and-aesthetics.md`](./docs/frontend-design-and-aesthetics.md))*
- Eradicates generic cookie-cutter templates, cliché gradients, uniform boxy cards, and robotic placeholder text. Enforces bespoke typography, layered surface architecture, and authentic domain realism.

### 11. Monorepo & Multi-Package Governance
*(Full detail: [`docs/monorepo-and-multirepo-governance.md`](./docs/monorepo-and-multirepo-governance.md))*
- Strict boundary isolation for multi-package monorepos (`pnpm-workspace.yaml`, Turborepo, Nx, Lerna), Rust workspaces, Go workspaces, and Git submodules. Enforces package-local context memory (`packages/*/CONTEXT.md`), topological build integrity, and quarantined blast radii.

### 12. The "Brahmastra" MCP Server & Agent Plugins
*(Full detail: [`bin/mcp-server.js`](./bin/mcp-server.js) and [`plugin.json`](./plugin.json))*
- Zero-dependency Model Context Protocol (MCP) server providing deterministic runtime tooling across all major agents (Claude Code, Cursor, Windsurf, Roo Code, Continue, Zed, Antigravity). Exposes `constitution_get_rule`, `constitution_validate`, `constitution_check_push`, and `constitution_benchmark` via standard JSON-RPC 2.0 stdio. Includes `.roomodes` for strict Architect, Builder, and Auditor role separation.

### 13. Limitless First-Principles Agency & 100-Year Timelessness
*(Full detail: [`docs/limitless-first-principles-agency.md`](./docs/limitless-first-principles-agency.md))*
- Eliminates learned helplessness and passive timidity. Guardrails act as an exoskeleton enabling fearless Mach-5 velocity. Agents operate on dual planes: surgical execution at the micro diff level, and unbounded first-principles reasoning at the macro architectural level (10x-100x scale anticipation, substrate independence).

---

## 🌐 Universal Model & Stack Agnostic

Agent Constitution is engineered from the ground up to be **model-neutral**:
- Works with **Frontier LLMs**: Claude 3.5 / 3.7 Sonnet, OpenAI GPT-4o / o1 / o3-mini, Google Gemini 2.0 Flash / Pro.
- Works with **Reasoning & Open-Source LLMs**: DeepSeek-R1 / V3, Qwen 2.5 Coder, Llama 3.3, Mistral Large.

It relies on universal structural constraints (checklists, negative constraints, machine-readable manifests) that any modern instruction-tuned model respects.

---

## 🗂️ Complete File Directory

| Document / Asset | Purpose |
|---|---|
| [`AGENTS.md`](./AGENTS.md) | **The Master Behavioral Contract**. Read first on every session. |
| [`CLAUDE.md`](./CLAUDE.md) | Universal adapter for Claude Code. |
| [`.cursorrules`](./.cursorrules) & [`.cursor/rules/`](./.cursor/rules/agent-constitution.mdc) | Universal adapters for Cursor (legacy & MDC formats). |
| [`.windsurfrules`](./.windsurfrules) | Universal adapter for Windsurf / Cascade. |
| [`.clinerules`](./.clinerules) | Universal adapter for Cline / Roo Code. |
| [`.github/copilot-instructions.md`](./.github/copilot-instructions.md) | Universal adapter for GitHub Copilot. |
| [`GEMINI.md`](./GEMINI.md) | Universal adapter for Gemini Code Assist / Google Antigravity. |
| [`.aider.conf.yml`](./.aider.conf.yml) | Universal adapter for Aider CLI. |
| [`.continue/config.json`](./.continue/config.json) | Universal adapter for Continue.dev. |
| [`.zed/settings.json`](./.zed/settings.json) | Universal adapter for Zed Editor. |
| [`docs/agent-decision-matrix.md`](./docs/agent-decision-matrix.md) | Autonomous decision rubric & 5-gate execution criteria for peak output. |
| [`docs/surgical-editing-and-scope-containment.md`](./docs/surgical-editing-and-scope-containment.md) | Eliminating cascading regressions and unrequested drive-by edits. |
| [`docs/drift-prevention-and-circuit-breakers.md`](./docs/drift-prevention-and-circuit-breakers.md) | Stopping agent tangents, context vomiting, and 3-strike loops. |
| [`docs/token-economy-and-max-output.md`](./docs/token-economy-and-max-output.md) | Heavy braining with minimal token consumption; zero echo rules. |
| [`docs/universal-stack-detection.md`](./docs/universal-stack-detection.md) | Dynamic auto-detection for ANY programming language or runtime. |
| [`docs/context-memory.md`](./docs/context-memory.md) | Token economics, compaction, and cross-session memory protocol. |
| [`docs/anti-hallucination-evidence.md`](./docs/anti-hallucination-evidence.md) | Epistemic grounding, citations, and evidence-first rules. |
| [`docs/task-management.md`](./docs/task-management.md) | PEV (Plan-Execute-Verify) engine and ambiguity scoring. |
| [`docs/non-regression-policy.md`](./docs/non-regression-policy.md) | Blast radius calculation and tripwire testing. |
| [`docs/security-and-depth.md`](./docs/security-and-depth.md) | Anti-sycophancy mandate and OWASP security review surface. |
| [`docs/safe-execution-guardrails.md`](./docs/safe-execution-guardrails.md) | Zero-data-loss and destructive command blacklist. |
| [`docs/git-and-github-push-guardrails.md`](./docs/git-and-github-push-guardrails.md) | Autonomous remote push lockout and branch protection. |
| [`docs/frontend-design-and-aesthetics.md`](./docs/frontend-design-and-aesthetics.md) | Bespoke visual standards, modern typography, and anti-AI-slop. |
| [`docs/proactive-autonomous-agency.md`](./docs/proactive-autonomous-agency.md) | Continuous invariant sentinel & predictive blast-radius alerts. |
| [`docs/limitless-first-principles-agency.md`](./docs/limitless-first-principles-agency.md) | First-principles reasoning, dual-plane cognition, and 100-year substrate independence. |
| [`docs/tdd-and-verification.md`](./docs/tdd-and-verification.md) | Red-Green-Refactor and bug reproduction protocols. |
| [`docs/subagent-orchestration.md`](./docs/subagent-orchestration.md) | Architect vs. Builder vs. Auditor multi-agent coordination. |
| [`docs/incident-response.md`](./docs/incident-response.md) | Circuit breaker trip, safe rollback, and post-mortem runbook. |
| [`docs/architecture-standards.md`](./docs/architecture-standards.md) | Clean Architecture, modular layouts, and file sizing limits. |
| [`docs/coding-standards.md`](./docs/coding-standards.md) | Defensive programming, zero placeholders, and error ergonomics. |
| [`docs/deployment-guide.md`](./docs/deployment-guide.md) | Twelve-Factor apps, zero-downtime migrations, and health probes. |
| [`docs/monorepo-and-multirepo-governance.md`](./docs/monorepo-and-multirepo-governance.md) | Multi-package workspaces, git submodules, and package quarantine boundaries. |
| [`docs/transforming-legacy-projects.md`](./docs/transforming-legacy-projects.md) | 5-stage transformation pipeline to elevate messy or legacy codebases into high-level systems. |
| [`docs/languages/`](./docs/languages/) | Deep stack conventions: Python, TypeScript/Node, Go, Rust, React/Web, Java/Kotlin, C#, C++, PHP, Ruby, Terraform, SQL. |
| [`templates/`](./templates/) | Drop-in templates: [`CONTEXT.md`](./templates/CONTEXT.md), [`TASKS.md`](./templates/TASKS.md), [`ADR.md`](./templates/ADR.md), [`INCIDENT_POSTMORTEM.md`](./templates/INCIDENT_POSTMORTEM.md), [`SECURITY_CHECKLIST.md`](./templates/SECURITY_CHECKLIST.md), [`HANDOFF.md`](./templates/HANDOFF.md), [`PHASE_PLAN.md`](./templates/PHASE_PLAN.md), [`AUDIT_REPORT.md`](./templates/AUDIT_REPORT.md), [`github-action-ci.yml`](./templates/github-action-ci.yml). |
| [`.githooks/`](./.githooks/) | Deterministic runtime guardrails: `pre-commit` (no leaks/placeholders), `pre-push` (push lockout). |
| [`scripts/`](./scripts/) | Automation: [`install.sh`](./scripts/install.sh), [`install.ps1`](./scripts/install.ps1), [`setup-hooks.sh`](./scripts/setup-hooks.sh), [`setup-hooks.ps1`](./scripts/setup-hooks.ps1), [`validate-constitution.sh`](./scripts/validate-constitution.sh), [`validate-constitution.ps1`](./scripts/validate-constitution.ps1). |
| [`bin/mcp-server.js`](./bin/mcp-server.js) | Universal Model Context Protocol (MCP) server ("Brahmastra" tool suite for all agents). |
| [`.roomodes`](./.roomodes) | Native custom mode configurations for Roo Code & Cline (Architect, Builder, Auditor). |
| [`.cursor/mcp.json`](./.cursor/mcp.json) & [`.mcp.json`](./.mcp.json) | Auto-discovery manifests for Cursor, Claude Code, and Windsurf MCP clients. |
| [`plugin.json`](./plugin.json) | Universal Claude Code plugin manifest. |
| [`benchmarks/`](./benchmarks/) | Empirical evaluation suite: [`run-benchmarks.js`](./benchmarks/run-benchmarks.js), [`README.md`](./benchmarks/README.md), [`EVAL_MATRIX.md`](./benchmarks/EVAL_MATRIX.md). |
| [`tests/`](./tests/) | Validation test suites: [`test_validation.sh`](./tests/test_validation.sh), [`test_validation.ps1`](./tests/test_validation.ps1). |
| [`SECURITY.md`](./SECURITY.md) & [`CODE_OF_CONDUCT.md`](./CODE_OF_CONDUCT.md) | Enterprise security disclosure policy & community standards. |
| [`package.json`](./package.json) & [`bin/cli.js`](./bin/cli.js) | Universal NPX distribution engine (`npx agent-constitution init/hooks/doctor/diff-guard/mcp/benchmark`). |
| [`CHANGELOG.md`](./CHANGELOG.md) & [`VERSION`](./VERSION) | Semantic version tracking (v1.0.0) and release history. |

---

## 🌟 Acknowledgements & Credits

Agent Constitution synthesizes and operationalizes the ground-breaking work of pioneers across AI research and software engineering:

- **Anthropic**: Constitutional AI philosophy, Claude system prompt architecture, and epistemic tool-use guidelines.
- **Google DeepMind**: Advanced agentic coding standards, tool grounding, and context window economics.
- **Aider ([paulgauthier/aider](https://github.com/paulgauthier/aider))**: Git-backed agent workflows, repo maps, and the Architect/Editor model.
- **Cursor ([cursor.com](https://cursor.com)) & Cursor Rules Community**: Pioneer of localized context governance via `.cursorrules` and `.cursor/rules/*.mdc`.
- **Superpowers & Agentic Workflow Community**: TDD agent execution loops, systematic debugging disciplines, and verification before completion.
- **Claude-Mem & MemPalace**: Persistent cross-session knowledge bases and project memory distillation.
- **GSD (Get-Stuff-Done) Engine**: Socratic scoping, ambiguity scoring matrices, and wave parallelization.
- **OpenHands & SWE-bench**: Empirical taxonomies of agent failure modes and benchmark evaluation.
- **OWASP Foundation**: Application Security Verification Standard (ASVS) and Top 10 vulnerabilities.
- **Kent Beck & Adam Wiggins**: Test-Driven Development (TDD) and The Twelve-Factor App.

For a full breakdown of references and citations, see [`ACKNOWLEDGEMENTS.md`](./ACKNOWLEDGEMENTS.md).

---

## 🚀 Recommended Infrastructure & Cloud VPS

> [!TIP]
> **Running 24/7 Autonomous AI Agents or Deploying Production Systems?**
>
> Autonomous coding agents, persistent background subagents, headless browser tests, and Docker microservices require robust Linux compute without cold-starts, rate limits, or container throttling.
>
> 🌐 **Deploy with [JME VPS (jmevps.com)](https://jmevps.com)**
> - **High-Performance Linux Cloud VPS**: Full root access, ultra-fast NVMe storage, and dedicated CPU cores for intensive compilation and testing.
> - **Tailored for Agentic Workflows**: Ideal for 24/7 autonomous agent execution, persistent DevContainers, self-hosted GitHub Actions runners, and background daemons.
> - **Production Reliability**: High-bandwidth network uplink, 99.9% uptime, and scalable resources for deploying your apps.
>
> 👉 Explore servers at **[https://jmevps.com](https://jmevps.com)** to power your AI and cloud infrastructure.

---

## ☕ Support & Sponsorship

If **Agent Constitution** saved your codebase from hallucinations, eliminated cascading regressions, or streamlined your agentic workflows, consider supporting the project!

<div align="center">

[![Buy Me A Coffee](https://img.shields.io/badge/Support-Buy%20Me%20A%20Coffee-orange?style=for-the-badge&logo=buy-me-a-coffee)](https://jmevps.com)
[![Support via UPI](https://img.shields.io/badge/Support-UPI%20%2F%20GPay%20%2F%20PhonePe-008080?style=for-the-badge&logo=googlepay)](#-support--sponsorship)

<br/>

**Direct UPI Support (GPay / PhonePe / Paytm / BHIM):**  
`jmetechno@ybl`

<br/>

<img src="https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=upi%3A%2F%2Fpay%3Fpa%3Djmetechno%40ybl%26pn%3DJME%20Techno%26cu%3DINR" width="180" height="180" alt="UPI QR Code - jmetechno@ybl" />

<br/>
<sub>Scan using any Indian UPI app (Google Pay, PhonePe, Paytm, BHIM, CRED). Contributions directly support open-source benchmarks and ongoing adapter maintenance.</sub>

</div>

---

## 🤝 Contributing

We welcome additions of new stack standards, IDE adapters, and real-world failure post-mortems! See [`CONTRIBUTING.md`](./CONTRIBUTING.md).

---

## 📄 License

[MIT License](./LICENSE) — Free to use, fork, and adapt for personal and enterprise projects.

---

<div align="center">
⭐ <b>If Agent Constitution saved your codebase from an agent-induced 2 AM incident, star this repository!</b>
</div>
