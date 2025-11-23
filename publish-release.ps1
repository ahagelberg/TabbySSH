# PowerShell script to build and package TabbySSH for release
# Usage: .\publish-release.ps1 [version]

param(
    [string]$Version = "1.1.0"
)

$ErrorActionPreference = "Stop"

Write-Host "Building TabbySSH v$Version for release..." -ForegroundColor Green

# Clean previous builds
Write-Host "Cleaning previous builds..." -ForegroundColor Yellow
dotnet clean -c Release

# Publish as self-contained Windows executable
Write-Host "Publishing Windows x64 release..." -ForegroundColor Yellow
dotnet publish -c Release -r win-x64 `
    --self-contained true `
    -p:PublishSingleFile=true `
    -p:IncludeNativeLibrariesForSelfExtract=true `
    -p:EnableCompressionInSingleFile=true `
    -p:DebugType=None `
    -p:DebugSymbols=false `
    -o ".\publish\TabbySSH-v$Version-win-x64"

# Create zip archive
Write-Host "Creating zip archive..." -ForegroundColor Yellow
$zipPath = ".\publish\TabbySSH-v$Version-win-x64.zip"
Compress-Archive -Path ".\publish\TabbySSH-v$Version-win-x64\*" -DestinationPath $zipPath -Force

Write-Host "`nRelease build complete!" -ForegroundColor Green
Write-Host "Output: $zipPath" -ForegroundColor Cyan
Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Test the executable in .\publish\TabbySSH-v$Version-win-x64\" -ForegroundColor White
Write-Host "2. Create a GitHub Release and upload: $zipPath" -ForegroundColor White


