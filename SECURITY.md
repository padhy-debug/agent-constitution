# Security Policy

## 🔒 Reporting a Vulnerability

The Agent Constitution project takes the security of autonomous development environments seriously. Because Agent Constitution governs how AI agents interact with local filesystems, shell execution environments, and git repositories, preventing unauthorized escape, credential leakage, and destructive execution is paramount.

If you believe you have found a security vulnerability in Agent Constitution (such as a gap in guardrails, command injection vectors in scripts, or bypasses in runtime git hooks):

1. **Do NOT open a public GitHub issue.**
2. Send a detailed report via email to: `security@agentconstitution.org` (or contact project maintainers privately).
3. Include:
   - A description of the vulnerability.
   - Exact steps or minimal reproducible prompt/environment to demonstrate the issue.
   - Any proposed remediation or mitigation.

## 🛡️ Supported Versions

| Version | Supported |
|---|---|
| 1.0.x | ✅ Supported |
| < 1.0 | ❌ End of Life |

## 🔍 Security Philosophy: Zero-Trust Agent Governance

Agent Constitution enforces defense-in-depth:
- **Layer 1: Contractual Prompt Governance** (`AGENTS.md`)
- **Layer 2: IDE & Tool Shims** (Cursor, Claude Code, Windsurf, Copilot, Antigravity)
- **Layer 3: Deterministic OS & Git Hooks** (`.githooks/pre-commit`, `.githooks/pre-push`)
- **Layer 4: CI Multi-OS Hardening** (GitHub Actions strict exit codes)
