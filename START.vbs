# SENTINEL Drone Fleet Manager - PowerShell Launcher
# Right-click this file and select "Run with PowerShell" or double-click after enabling scripts

$appPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$indexHtml = Join-Path $appPath "index.html"

Write-Host "🛸 Launching SENTINEL Drone Fleet Manager..." -ForegroundColor Cyan
Write-Host "   Opening in default browser..." -ForegroundColor Yellow

# Open in default browser
if (Test-Path $indexHtml) {
    Start-Process $indexHtml
    Write-Host "   ✓ Application launched!" -ForegroundColor Green
    Start-Sleep -Seconds 2
} else {
    Write-Host "   ✗ Error: index.html not found!" -ForegroundColor Red
    Write-Host "   Path: $indexHtml" -ForegroundColor Red
    Read-Host "Press Enter to exit"
}
