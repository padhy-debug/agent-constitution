#!/usr/bin/env bash
# Agent Constitution - Universal Drop-in Installer
# Installs AGENTS.md, docs/, templates/, and tool adapters into the target project.

set -euo pipefail

TARGET_DIR="${1:-.}"

echo "🧠 Installing Agent Constitution into: ${TARGET_DIR}"

# Create target directories
mkdir -p "${TARGET_DIR}/docs/languages"
mkdir -p "${TARGET_DIR}/templates"
mkdir -p "${TARGET_DIR}/.cursor/rules"
mkdir -p "${TARGET_DIR}/.github"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Copy core contract & docs
cp -f "${SCRIPT_DIR}/AGENTS.md" "${TARGET_DIR}/"
cp -rf "${SCRIPT_DIR}/docs/"* "${TARGET_DIR}/docs/"
cp -rf "${SCRIPT_DIR}/templates/"* "${TARGET_DIR}/templates/"

# Initialize CONTEXT.md and TASKS.md if they do not exist
if [ ! -f "${TARGET_DIR}/CONTEXT.md" ]; then
    cp "${TARGET_DIR}/templates/CONTEXT.md" "${TARGET_DIR}/CONTEXT.md"
    echo "  + Created CONTEXT.md from template"
fi

if [ ! -f "${TARGET_DIR}/TASKS.md" ]; then
    cp "${TARGET_DIR}/templates/TASKS.md" "${TARGET_DIR}/TASKS.md"
    echo "  + Created TASKS.md from template"
fi

# Copy tool adapters
cp -f "${SCRIPT_DIR}/CLAUDE.md" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.cursorrules" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.windsurfrules" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.clinerules" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/GEMINI.md" "${TARGET_DIR}/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.cursor/rules/agent-constitution.mdc" "${TARGET_DIR}/.cursor/rules/" 2>/dev/null || true
cp -f "${SCRIPT_DIR}/.github/copilot-instructions.md" "${TARGET_DIR}/.github/" 2>/dev/null || true

echo "✅ Agent Constitution installed successfully!"
echo "   Next steps:"
echo "   1. Fill in your tech stack details in CONTEXT.md"
echo "   2. Add your current goals in TASKS.md"
echo "   3. Point your AI agent at AGENTS.md and enjoy disciplined engineering!"
