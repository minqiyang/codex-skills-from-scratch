[CmdletBinding()]
param(
    [switch]$Install
)

$ErrorActionPreference = 'Stop'

$ScriptPath = if ($PSCommandPath) { $PSCommandPath } else { $MyInvocation.MyCommand.Path }
$ScriptsDir = Split-Path -Parent $ScriptPath
$RepoRoot = Split-Path -Parent $ScriptsDir
$Source = Join-Path $RepoRoot 'skills\skill-maker\SKILL.md'
$Target = Join-Path $env:USERPROFILE '.agents\skills\skill-maker\SKILL.md'
$TargetDir = Split-Path -Parent $Target
$Mode = if ($Install.IsPresent) { 'install' } else { 'dry-run' }

Write-Output 'Codex Skill Maker install report'
Write-Output "Mode: $Mode"
Write-Output "Repo root: $RepoRoot"
Write-Output "Source: $Source"
Write-Output "Target: $Target"

if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) {
    throw "Source Skill not found: $Source"
}

if (-not $Install.IsPresent) {
    Write-Output 'Dry-run actions:'
    Write-Output "Would ensure target directory exists: $TargetDir"
    if (Test-Path -LiteralPath $Target -PathType Leaf) {
        $PreviewBackup = Join-Path $TargetDir ('SKILL.md.bak-{0}' -f (Get-Date -Format 'yyyyMMdd-HHmmss'))
        Write-Output "Would back up existing target to: $PreviewBackup"
    } else {
        Write-Output 'Would skip backup because target does not exist.'
    }
    Write-Output 'Would copy source Skill to target.'
    Write-Output 'No files were changed. Run with -Install to perform the installation.'
    return
}

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

if (Test-Path -LiteralPath $Target -PathType Leaf) {
    $Backup = Join-Path $TargetDir ('SKILL.md.bak-{0}' -f (Get-Date -Format 'yyyyMMdd-HHmmss'))
    Copy-Item -LiteralPath $Target -Destination $Backup
    Write-Output "Backed up existing target to: $Backup"
} else {
    Write-Output 'No existing target found; backup skipped.'
}

Copy-Item -LiteralPath $Source -Destination $Target -Force
Write-Output 'Installed Skill Maker successfully.'
