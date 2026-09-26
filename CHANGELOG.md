# Changelog

All notable changes to Agent Constitution are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0-rc1] - 2026-09-26

### Added
- **Self-Compliance Bootstrap**: Root-level `CONTEXT.md` and `TASKS.md` for the repository itself.
- **Cross-Platform Compliance Validation**:
  - `scripts/validate-constitution.ps1` for native Windows PowerShell verification.
  - Enhanced `scripts/validate-constitution.sh` with doc checks and placeholder warnings.
- **Harden CI Pipeline**: Multi-OS GitHub Actions workflow (`ubuntu-latest` + `windows-latest`) with strict exit code validation.
- **Expanded Language Standards** in `docs/languages/`:
  - `csharp.md`: Modern C# (.NET 8/9+), nullable reference types, and ASP.NET Core practices.
  - `cpp.md`: Modern C++20/23, RAII, smart pointers, concepts, and sanitizers.
  - `php.md`: Modern PHP 8.2/8.3+, strict types, readonly classes, and PHPStan.
  - `ruby.md`: Ruby 3.x, Sorbet/RBS, pattern matching, RuboCop, and RSpec.
  - `terraform.md`: HCL, remote state locking, tflint, trivy, and blast-radius planning.
  - `sql.md`: Zero-downtime migrations, concurrent index creation, transaction isolation, and injection prevention.
- **Operational Subagent Templates** in `templates/`:
  - `HANDOFF.md`: Context bundle transfer format between Architect, Builder, and Auditor.
  - `PHASE_PLAN.md`: Structured implementation plan format produced by Architect.
  - `AUDIT_REPORT.md`: Adversarial verification and OWASP sign-off format produced by Auditor.
- **Incident Response Protocol**:
  - `docs/incident-response.md`: 4-step containment workflow for 3-strike circuit breaker trips and regression rollbacks.
- **Git Push Guardrails**:
  - `docs/git-and-github-push-guardrails.md`: Hard lockout on autonomous remote `git push`, branch protection on primary branches (`main`/`master`), atomic commits, and 4-point pre-push tripwire.
- **Modern Frontend Aesthetics & Anti-AI-Slop**:
  - `docs/frontend-design-and-aesthetics.md`: Mandate eradicating generic cookie-cutter templates, boxy clones, and placeholder copy. Enforces layered surface architecture, bespoke typography, fluid CSS scales, and authentic domain realism.
- **Scale-Horizon Architecture**:
  - Upgraded `docs/context-memory.md` with 3-Tier Lifespan model (Hot, Warm, Cold) and 10x-100x scale horizon planning.
  - Added System Scale & Evolutionary Horizon section to `templates/CONTEXT.md` and root `CONTEXT.md`.
- **Extended Tool Adapters**:
  - `.aider.conf.yml`: Aider CLI integration.
  - `.continue/config.json`: Continue.dev integration with `/audit` and `/close-session` commands.
  - `.zed/settings.json`: Zed AI assistant integration.
  - Synchronized all tool adapters (`GEMINI.md`, `CLAUDE.md`, `.cursorrules`, `.windsurfrules`, `.clinerules`, `.github/copilot-instructions.md`) with push lockout, aesthetics, and scale-horizon directives.
- **Machine-Readable Versioning**: Added `VERSION` file.

### Changed
- Clarified `README.md` Quick Start commands with local installation flags and verification instructions.
- Updated `scripts/install.sh` and `scripts/install.ps1` to bundle validation tooling for target projects.
- Linked `SECURITY_CHECKLIST.md` and operational templates across `AGENTS.md` and `docs/`.
