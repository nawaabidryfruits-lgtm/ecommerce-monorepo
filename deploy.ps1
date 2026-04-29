# ============================================================================
# Manual Deployment Script - Render
# ============================================================================
# Usage: .\deploy.ps1
# This script deploys all 3 services manually via Render API.
# Requires: RENDER_API_KEY environment variable set
# ============================================================================

param(
    [string]$BackendServiceId = $env:RENDER_BACKEND_SERVICE_ID,
    [string]$FrontendServiceId = $env:RENDER_FRONTEND_SERVICE_ID,
    [string]$AdminServiceId = $env:RENDER_ADMIN_SERVICE_ID,
    [string]$ApiKey = $env:RENDER_API_KEY
)

$ErrorActionPreference = "Stop"

# Colors for output
$Green = "Green"
$Yellow = "Yellow"
$Red = "Red"
$Cyan = "Cyan"

Write-Host "`n========================================" -ForegroundColor $Cyan
Write-Host "  Ecommerce Deploy Script (Render)" -ForegroundColor $Cyan
Write-Host "========================================`n" -ForegroundColor $Cyan

# Check prerequisites
if (-not $ApiKey) {
    Write-Host "ERROR: RENDER_API_KEY not set!" -ForegroundColor $Red
    Write-Host "Get your API key from: https://dashboard.render.com/account/api-keys" -ForegroundColor $Yellow
    Write-Host "Then run: `$env:RENDER_API_KEY = 'your_key'" -ForegroundColor $Yellow
    exit 1
}

# Helper function to trigger deploy
function Deploy-Service {
    param(
        [string]$Name,
        [string]$ServiceId,
        [string]$Type = "web"
    )

    if (-not $ServiceId) {
        Write-Host "WARNING: Service ID not set for $Name, skipping..." -ForegroundColor $Yellow
        return
    }

    Write-Host "Deploying $Name..." -ForegroundColor $Cyan -NoNewline

    try {
        $headers = @{
            "Authorization" = "Bearer $ApiKey"
            "Accept" = "application/json"
            "Content-Type" = "application/json"
        }

        $body = '{"clearCache": "do_not_clear"}'

        Invoke-RestMethod -Uri "https://api.render.com/v1/services/$ServiceId/deploys" `
            -Method POST `
            -Headers $headers `
            -Body $body | Out-Null

        Write-Host " OK" -ForegroundColor $Green
        Write-Host "  -> Dashboard: https://dashboard.render.com/$Type/$ServiceId" -ForegroundColor $Gray
    }
    catch {
        Write-Host " FAILED" -ForegroundColor $Red
        Write-Host "  -> Error: $_" -ForegroundColor $Red
    }
}

# Deploy all services
Write-Host "`nTriggering deployments...`n" -ForegroundColor $Cyan

Deploy-Service -Name "Backend (API)" -ServiceId $BackendServiceId -Type "web"
Deploy-Service -Name "Frontend (Store)" -ServiceId $FrontendServiceId -Type "static"
Deploy-Service -Name "Admin (Dashboard)" -ServiceId $AdminServiceId -Type "static"

Write-Host "`n========================================" -ForegroundColor $Cyan
Write-Host "  Deployments triggered!" -ForegroundColor $Green
Write-Host "========================================" -ForegroundColor $Cyan
Write-Host "Monitor at: https://dashboard.render.com" -ForegroundColor $Yellow
Write-Host "`nTip: To get Service IDs, run:" -ForegroundColor $Gray
Write-Host "  curl -s https://api.render.com/v1/services -H `"Authorization: Bearer `$env:RENDER_API_KEY`"`n" -ForegroundColor $Gray
