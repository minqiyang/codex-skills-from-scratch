[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$ScriptPath = if ($PSCommandPath) { $PSCommandPath } else { $MyInvocation.MyCommand.Path }
$ScriptsDir = Split-Path -Parent $ScriptPath
$RepoRoot = Split-Path -Parent $ScriptsDir
$UserSkillMaker = Join-Path $env:USERPROFILE '.agents\skills\skill-maker\SKILL.md'
$ExampleInstallTarget = Join-Path $env:USERPROFILE '.agents\skills\market-research\SKILL.md'

$Pass = New-Object System.Collections.Generic.List[string]
$Risk = New-Object System.Collections.Generic.List[string]
$Info = New-Object System.Collections.Generic.List[string]

function Add-Pass {
    param([string]$Message)
    $Pass.Add($Message) | Out-Null
}

function Add-Risk {
    param([string]$Message)
    $Risk.Add($Message) | Out-Null
}

function Add-Info {
    param([string]$Message)
    $Info.Add($Message) | Out-Null
}

function Get-SkillMetadata {
    param([string]$Path)

    $Text = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    $FenceMarker = ([string][char]96) + ([string][char]96) + ([string][char]96)
    $FenceCount = ([regex]::Matches($Text, [regex]::Escape($FenceMarker))).Count
    $Metadata = [ordered]@{
        Path = $Path
        Name = $null
        Description = $null
        HasFrontmatter = $false
        FenceCount = $FenceCount
        FencesBalanced = ($FenceCount % 2 -eq 0)
    }

    $Match = [regex]::Match($Text, '(?s)\A---\s*(.*?)\s*---')
    if ($Match.Success) {
        $Metadata.HasFrontmatter = $true
        $Frontmatter = $Match.Groups[1].Value -split "`r?`n"
        foreach ($Line in $Frontmatter) {
            if ($Line -match '^name:\s*(.+?)\s*$') {
                $Metadata.Name = $Matches[1]
            }
            if ($Line -match '^description:\s*(.+?)\s*$') {
                $Metadata.Description = $Matches[1]
            }
        }
    }

    [pscustomobject]$Metadata
}

$RepoSkillFiles = @()
if (Test-Path -LiteralPath $RepoRoot) {
    $RepoSkillFiles = @(Get-ChildItem -LiteralPath $RepoRoot -Recurse -Filter 'SKILL.md' -File)
}

$SkillFiles = @($RepoSkillFiles)
if (Test-Path -LiteralPath $UserSkillMaker -PathType Leaf) {
    $SkillFiles += Get-Item -LiteralPath $UserSkillMaker
}

$Metadata = @()
foreach ($File in $SkillFiles) {
    $Item = Get-SkillMetadata -Path $File.FullName
    $Metadata += $Item

    if ($Item.HasFrontmatter -and $Item.Name -and $Item.Description) {
        Add-Pass "Frontmatter has name and description: $($Item.Path)"
    } else {
        Add-Risk "Missing frontmatter name or description: $($Item.Path)"
    }

    if ($Item.FencesBalanced) {
        Add-Pass "Markdown code fences are closed: $($Item.Path)"
    } else {
        Add-Risk "Markdown code fences are not closed: $($Item.Path)"
    }
}

$RepoNameGroups = $Metadata |
    Where-Object { $_.Path.StartsWith($RepoRoot, [System.StringComparison]::OrdinalIgnoreCase) -and $_.Name } |
    Group-Object -Property Name |
    Where-Object { $_.Count -gt 1 }

foreach ($Group in $RepoNameGroups) {
    Add-Risk "Duplicate Skill name inside repo: $($Group.Name)"
}

if (-not $RepoNameGroups) {
    Add-Pass 'No duplicate Skill names inside repo.'
}

$UserSkillMakerMatches = @($Metadata | Where-Object {
    $_.Path -ieq $UserSkillMaker -and $_.Name -eq 'skill-maker'
})
if ($UserSkillMakerMatches.Count -eq 1) {
    Add-Pass 'Exactly one official user-level skill-maker was found at the expected path.'
} else {
    Add-Risk 'Official user-level skill-maker was not found exactly once at the expected path.'
}

if (Test-Path -LiteralPath $ExampleInstallTarget -PathType Leaf) {
    Add-Risk "Example market-research appears installed as a callable user Skill: $ExampleInstallTarget"
} else {
    Add-Pass 'Example market-research is not installed as a callable user Skill.'
}

$NameSkipPattern = '(?i)(^' + '\.' + 'env$|se' + 'cret|credential|private|key|to' + 'ken|pass' + 'word)'
$KeywordPattern = '(?i)(to' + 'ken|api' + '_key|pass' + 'word|se' + 'cret|\.' + 'env)'
$ScanFiles = Get-ChildItem -LiteralPath $RepoRoot -Recurse -File -Include '*.md','*.ps1'
if (Test-Path -LiteralPath $UserSkillMaker -PathType Leaf) {
    $ScanFiles += Get-Item -LiteralPath $UserSkillMaker
}

foreach ($File in $ScanFiles | Sort-Object FullName -Unique) {
    if ($File.Name -match $NameSkipPattern) {
        Add-Risk "Suspicious file name was not opened: $($File.FullName)"
        continue
    }

    $Hits = Select-String -LiteralPath $File.FullName -Pattern $KeywordPattern -CaseSensitive:$false -ErrorAction SilentlyContinue
    foreach ($Hit in $Hits) {
        Add-Risk "Sensitive keyword candidate in $($Hit.Path): line $($Hit.LineNumber)"
    }
}

if (-not ($Risk | Where-Object { $_ -like 'Sensitive keyword candidate*' -or $_ -like 'Suspicious file name*' })) {
    Add-Pass 'No obvious sensitive keyword candidates found in audited text files.'
}

$RepoSource = Join-Path $RepoRoot 'skills\skill-maker\SKILL.md'
if (Test-Path -LiteralPath $RepoSource -PathType Leaf) {
    Add-Pass "Repo Skill Maker source exists: $RepoSource"
} else {
    Add-Risk "Repo Skill Maker source is missing: $RepoSource"
}

Add-Info "Repo root: $RepoRoot"
Add-Info "User-level Skill Maker path: $UserSkillMaker"

Write-Output 'Codex Skills audit summary'
Write-Output ''
Write-Output 'Pass items:'
foreach ($Item in $Pass) {
    Write-Output "PASS: $Item"
}

Write-Output ''
Write-Output 'Risk items:'
if ($Risk.Count -eq 0) {
    Write-Output 'RISK: none'
} else {
    foreach ($Item in $Risk) {
        Write-Output "RISK: $Item"
    }
}

Write-Output ''
Write-Output 'Info:'
foreach ($Item in $Info) {
    Write-Output "INFO: $Item"
}
