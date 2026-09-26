<#
.SYNOPSIS
    Activates Agent Constitution Git Hooks on Windows PowerShell.
#>

$ErrorActionPreference = "Stop"

Write-Host "Activating Agent Constitution Git Hooks..." -ForegroundColor Cyan

if (-not (Test-Path ".git")) {
    Write-Host "Error: .git directory not found. Please run this inside a git repository." -ForegroundColor Red
    exit 1
}

git config core.hooksPath .githooks

Write-Host "Git hooks configured! Pre-commit and pre-push guardrails are now active." -ForegroundColor Green
Write-Host "  - Pre-commit: Blocks unpopulated templates and leaks"
Write-Host "  - Pre-push: Prevents direct push to main/master and unauthorized agent pushes"
