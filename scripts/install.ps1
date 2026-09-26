<#
.SYNOPSIS
    Agent Constitution Universal Installer for Windows PowerShell
.DESCRIPTION
    Installs AGENTS.md, docs, templates, and agent tool adapters into a target project.
.PARAMETER TargetDir
    The target directory where Agent Constitution should be installed. Defaults to current directory.
#>

param (
    [string]$TargetDir = "."
)

$ErrorActionPreference = "Stop"

Write-Host "🧠 Installing Agent Constitution into: $TargetDir" -ForegroundColor Cyan

$scriptRoot = Split-Path -Parent $PSScriptRoot

# Create destination directories
$docsDir = Join-Path $TargetDir "docs\languages"
$templatesDir = Join-Path $TargetDir "templates"
$cursorRulesDir = Join-Path $TargetDir ".cursor\rules"
$githubDir = Join-Path $TargetDir ".github"

New-Item -ItemType Directory -Force -Path $docsDir | Out-Null
New-Item -ItemType Directory -Force -Path $templatesDir | Out-Null
New-Item -ItemType Directory -Force -Path $cursorRulesDir | Out-Null
New-Item -ItemType Directory -Force -Path $githubDir | Out-Null

# Copy core files
Copy-Item -Path (Join-Path $scriptRoot "AGENTS.md") -Destination $TargetDir -Force
Copy-Item -Path (Join-Path $scriptRoot "docs\*") -Destination (Join-Path $TargetDir "docs") -Recurse -Force
Copy-Item -Path (Join-Path $scriptRoot "templates\*") -Destination (Join-Path $TargetDir "templates") -Recurse -Force

# Initialize CONTEXT.md and TASKS.md if missing
$contextPath = Join-Path $TargetDir "CONTEXT.md"
if (-not (Test-Path $contextPath)) {
    Copy-Item -Path (Join-Path $TargetDir "templates\CONTEXT.md") -Destination $contextPath
    Write-Host "  + Created CONTEXT.md from template" -ForegroundColor Green
}

$tasksPath = Join-Path $TargetDir "TASKS.md"
if (-not (Test-Path $tasksPath)) {
    Copy-Item -Path (Join-Path $TargetDir "templates\TASKS.md") -Destination $tasksPath
    Write-Host "  + Created TASKS.md from template" -ForegroundColor Green
}

# Copy adapters
$adapters = @("CLAUDE.md", ".cursorrules", ".windsurfrules", ".clinerules", "GEMINI.md")
foreach ($adapter in $adapters) {
    $src = Join-Path $scriptRoot $adapter
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $TargetDir -Force
    }
}

$mdcSrc = Join-Path $scriptRoot ".cursor\rules\agent-constitution.mdc"
if (Test-Path $mdcSrc) {
    Copy-Item -Path $mdcSrc -Destination $cursorRulesDir -Force
}

$copilotSrc = Join-Path $scriptRoot ".github\copilot-instructions.md"
if (Test-Path $copilotSrc) {
    Copy-Item -Path $copilotSrc -Destination $githubDir -Force
}

Write-Host "✅ Agent Constitution installed successfully!" -ForegroundColor Green
Write-Host "   Next steps:" -ForegroundColor Yellow
Write-Host "   1. Fill in your tech stack details in CONTEXT.md"
Write-Host "   2. Add your current goals in TASKS.md"
Write-Host "   3. Point your AI agent at AGENTS.md and enjoy disciplined engineering!"
