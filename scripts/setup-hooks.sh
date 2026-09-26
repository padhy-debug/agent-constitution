#!/usr/bin/env bash
# Agent Constitution - Git Hooks Activation Script
# Configures local repository to run .githooks/ automatically.

set -euo pipefail

echo "🔗 Activating Agent Constitution Git Hooks..."

if [ ! -d ".git" ]; then
    echo "❌ Error: .git directory not found. Please run this inside a git repository."
    exit 1
fi

chmod +x .githooks/* 2>/dev/null || true
git config core.hooksPath .githooks

echo "✅ Git hooks configured! Pre-commit and pre-push guardrails are now active."
echo "   - Pre-commit: Blocks unpopulated templates and leaks"
echo "   - Pre-push: Prevents direct push to main/master and unauthorized agent pushes"
