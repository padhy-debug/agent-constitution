#!/usr/bin/env bash
# Agent Constitution - Universal Drop-in Installer
# Installs AGENTS.md, docs/, templates/, scripts/, bin/, benchmarks/, and tool adapters into the target project.

set -euo pipefail

TARGET_DIR="${1:-.}"

echo "🧠 Installing Agent Constitution into: ${TARGET_DIR}"

# Create target directories
mkdir -p "${TARGET_DIR}/docs/languages"
mkdir -p "${TARGET_DIR}/templates"
mkdir -p "${TARGET_DIR}/scripts"
mkdir -p "${TARGET_DIR}/bin"
mkdir -p "${TARGET_DIR}/benchmarks"
mkdir -p "${TARGET_DIR}/.githooks"
mkdir -p "${TARGET_DIR}/.cursor/rules"
mkdir -p "${TARGET_DIR}/.github"
mkdir -p "${TARGET_DIR}/.continue"
mkdir -p "${TARGET_DIR}/.zed"
mkdir -p "${TARGET_DIR}/.vscode"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Copy core contract & docs
cp -f "${SCRIPT_DIR}/AGENTS.md" "${TARGET_DIR}/"
cp -rf "${SCRIPT_DIR}/docs/"* "${TARGET_DIR}/docs/"
cp -rf "${SCRIPT_DIR}/templates/"* "${TARGET_DIR}/templates/"
cp -rf "${SCRIPT_DIR}/scripts/"* "${TARGET_DIR}/scripts/"
cp -rf "${SCRIPT_DIR}/bin/"* "${TARGET_DIR}/bin/"
cp -rf "${SCRIPT_DIR}/benchmarks/"* "${TARGET_DIR}/benchmarks/"
cp -rf "${SCRIPT_DIR}/.githooks/"* "${TARGET_DIR}/.githooks/"

# Initialize CONTEXT.md and TASKS.md if they do not exist
if [ ! -f "${TARGET_DIR}/CONTEXT.md" ]; then
    cp "${TARGET_DIR}/templates/CONTEXT.md" "${TARGET_DIR}/CONTEXT.md"
    echo "  + Created CONTEXT.md from template"
fi

if [ ! -f "${TARGET_DIR}/TASKS.md" ]; then
    cp "${TARGET_DIR}/templates/TASKS.md" "${TARGET_DIR}/TASKS.md"
    echo "  + Created TASKS.md from template"
fi

# Copy tool adapters, plugins, and custom modes
cp -f "${SCRIPT_DIR}/CLAUDE.md" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.cursorrules" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.windsurfrules" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.clinerules" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/GEMINI.md" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.aider.conf.yml" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.roomodes" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/plugin.json" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.mcp.json" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.cursor/mcp.json" "${TARGET_DIR}/.cursor/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.cursor/rules/agent-constitution.mdc" "${TARGET_DIR}/.cursor/rules/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.github/copilot-instructions.md" "${TARGET_DIR}/.github/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.continue/config.json" "${TARGET_DIR}/.continue/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.zed/settings.json" "${TARGET_DIR}/.zed/" 2>/dev/null || true
cp -rf "${SCRIPT_DIR}/.vscode/"* "${TARGET_DIR}/.vscode/" 2>/dev/null || true

echo "✅ Agent Constitution installed successfully!"
echo "   Next steps:"
echo "   1. Fill in your tech stack details in CONTEXT.md"
echo "   2. Add your current goals in TASKS.md"
echo "   3. Run 'bash ./scripts/setup-hooks.sh' to activate Git push guardrails"
echo "   4. Start MCP server with 'node bin/mcp-server.js' or use Cursor/Claude Code/Roo Code natively"
echo "   5. Point your AI agent at AGENTS.md and enjoy disciplined engineering!"
