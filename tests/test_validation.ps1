$ErrorActionPreference = "Stop"
$testExitCode = 0

Write-Host "Running Agent Constitution Validation Test Suite..." -ForegroundColor Cyan

# Test 1: Validate current repository passes
Write-Host ""
Write-Host "Test 1: Self-compliance check of agent-constitution repo..."
& .\scripts\validate-constitution.ps1 -TargetDir .
if ($LASTEXITCODE -ne 0) {
    Write-Host "FAIL: Test 1 failed - repository did not pass self-validation!" -ForegroundColor Red
    $testExitCode = 1
} else {
    Write-Host "PASS: Test 1 passed successfully." -ForegroundColor Green
}

# Test 2: Detect missing mandatory file in empty directory
Write-Host ""
Write-Host "Test 2: Assert failure on empty directory..."
$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ("agent-const-test-" + [System.Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tempDir | Out-Null

try {
    & .\scripts\validate-constitution.ps1 -TargetDir $tempDir
    if ($LASTEXITCODE -eq 0) {
        Write-Host "FAIL: Test 2 failed - validator should have returned non-zero exit code for empty directory!" -ForegroundColor Red
        $testExitCode = 1
    } else {
        Write-Host "PASS: Test 2 passed - correctly caught missing files in empty directory." -ForegroundColor Green
    }
} finally {
    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}

# Test 3: Test install.ps1 into temp directory and validate it
Write-Host ""
Write-Host "Test 3: End-to-end install and validate in new directory..."
$installTestDir = Join-Path ([System.IO.Path]::GetTempPath()) ("agent-const-install-" + [System.Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $installTestDir | Out-Null

try {
    & .\scripts\install.ps1 -TargetDir $installTestDir
    & .\scripts\validate-constitution.ps1 -TargetDir $installTestDir
    if ($LASTEXITCODE -ne 0) {
        Write-Host "FAIL: Test 3 failed - installed repository did not pass validation!" -ForegroundColor Red
        $testExitCode = 1
    } else {
        Write-Host "PASS: Test 3 passed - install and validate cycle succeeded." -ForegroundColor Green
    }
} finally {
    Remove-Item -Path $installTestDir -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host ""
if ($testExitCode -eq 0) {
    Write-Host "ALL TESTS PASSED (3/3)" -ForegroundColor Green
} else {
    Write-Host "TEST SUITE FAILED" -ForegroundColor Red
}

exit $testExitCode
