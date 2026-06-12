[CmdletBinding()]
param(
    [ValidateSet('Local', 'CI')]
    [string]$Mode
)

$ErrorActionPreference = 'Stop'

if (-not $PSBoundParameters.ContainsKey('Mode')) {
    if ($env:GITHUB_ACTIONS -eq 'true') {
        $Mode = 'CI'
    } else {
        $Mode = 'Local'
    }
}

$ScriptPath = if ($PSCommandPath) { $PSCommandPath } else { $MyInvocation.MyCommand.Path }
$ScriptsDir = Split-Path -Parent $ScriptPath
$RepoRoot = Split-Path -Parent $ScriptsDir
$UserSkillMaker = Join-Path $env:USERPROFILE '.agents\skills\skill-maker\SKILL.md'
$ExampleInstallTarget = Join-Path $env:USERPROFILE '.agents\skills\market-research\SKILL.md'
$RepoSource = Join-Path $RepoRoot 'skills\skill-maker\SKILL.md'
$InstallScript = Join-Path $RepoRoot 'scripts\install.ps1'

$Pass = New-Object System.Collections.Generic.List[string]
$AllowedReference = New-Object System.Collections.Generic.List[string]
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

function Add-AllowedReference {
    param([string]$Message)
    $AllowedReference.Add($Message) | Out-Null
}

function Add-Info {
    param([string]$Message)
    $Info.Add($Message) | Out-Null
}

function Get-RepoRelativePath {
    param([string]$Path)

    if ($Path.StartsWith($RepoRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $Path.Substring($RepoRoot.Length).TrimStart([char[]]@('\', '/'))
    }

    return $Path
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
if ($Mode -eq 'Local' -and (Test-Path -LiteralPath $UserSkillMaker -PathType Leaf)) {
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

$UserSkillMakerMatches = @()
if ($Mode -eq 'Local') {
    $UserSkillMakerMatches = @($Metadata | Where-Object {
        $_.Path -ieq $UserSkillMaker -and $_.Name -eq 'skill-maker'
    })
    if ($UserSkillMakerMatches.Count -eq 1) {
        Add-Pass 'Exactly one official user-level skill-maker was found at the expected path.'
    } else {
        Add-Risk 'Official user-level skill-maker was not found exactly once at the expected path.'
    }

    if ((Test-Path -LiteralPath $RepoSource -PathType Leaf) -and (Test-Path -LiteralPath $UserSkillMaker -PathType Leaf)) {
        $RepoHash = (Get-FileHash -LiteralPath $RepoSource -Algorithm SHA256).Hash
        $UserHash = (Get-FileHash -LiteralPath $UserSkillMaker -Algorithm SHA256).Hash
        if ($RepoHash -eq $UserHash) {
            Add-Pass 'User-level skill-maker matches the repo source copy.'
        } else {
            Add-Risk 'User-level skill-maker differs from the repo source copy.'
        }
    }
} else {
    Add-Info "CI mode skips user-level Skill Maker install check: $UserSkillMaker"
}

if (Test-Path -LiteralPath $ExampleInstallTarget -PathType Leaf) {
    Add-Risk "Example market-research appears installed as a callable user Skill: $ExampleInstallTarget"
} else {
    Add-Pass 'Example market-research is not installed as a callable user Skill.'
}

$AllowedGitIgnorePatterns = @(
    '.env',
    '*.env',
    '*.key',
    '*.pem',
    '*token*',
    '*secret*',
    'credentials*',
    'backup/',
    '*.bak',
    '__pycache__/',
    '.pytest_cache/',
    '.DS_Store',
    'Thumbs.db'
)

function Test-SensitiveFileName {
    param([System.IO.FileInfo]$File)

    $Name = $File.Name.ToLowerInvariant()
    return (
        $Name -eq '.env' -or
        $Name.EndsWith('.env') -or
        $Name.EndsWith('.key') -or
        $Name.EndsWith('.pem') -or
        $Name.Contains('token') -or
        $Name.Contains('secret') -or
        $Name.StartsWith('credentials') -or
        ($Name.Contains('private') -and $Name.Contains('key'))
    )
}

function Test-SecretAssignmentLine {
    param([string]$Line)

    $SecretNamePattern = '(api[_-]?key|apikey|token|password|secret|credential)'
    $AssignmentPattern = '(?i)\b' + $SecretNamePattern + '\b\s*[:=]\s*[''"]?[^''"\s<#][^#\r\n]{3,}'
    return ($Line -match $AssignmentPattern)
}

function Get-AllowedReferenceReason {
    param(
        [System.IO.FileInfo]$File,
        [string]$Line
    )

    $Trimmed = $Line.Trim()
    $RelativePath = Get-RepoRelativePath -Path $File.FullName

    if ($File.Name -eq '.gitignore' -and ($AllowedGitIgnorePatterns -contains $Trimmed)) {
        return 'expected .gitignore exclusion pattern'
    }

    $Lower = $Trimmed.ToLowerInvariant()
    if ($RelativePath -like 'skills\codex-long-session-governance\*') {
        if (
            $Lower -match '\btoken\b' -or
            $Lower -match '\btokens\b' -or
            $Lower -match '\btoken budget\b' -or
            $Lower -match '\btoken use\b' -or
            $Lower -match '\bguardrail' -or
            $Lower -match '\bdo not\b' -or
            $Lower -match '\bnot\b' -or
            $Lower -match '\bwithout\b' -or
            $Lower -match '\bunless\b' -or
            $Lower -match '\bstop\b' -or
            $Lower -match '\bcredential' -or
            $Lower -match '\bsecret' -or
            $Lower -match '\bapi key' -or
            $Lower -match '\bprivate key' -or
            $Lower -match '\bconfig\.toml\b' -or
            $Lower -match '\bsensitive-keyword\b' -or
            $Lower -match '\braw data\b'
        ) {
            return 'approved long-session governance guardrail wording'
        }
    }

    if ($RelativePath -like 'docs\*' -or $File.Name -in @('README.md', 'prompt-templates.md')) {
        if (
            $Lower -match '\bdo not\b' -or
            $Lower -match '\bnot\b' -or
            $Lower -match '\bwithout\b' -or
            $Lower -match '\bunless\b' -or
            $Lower -match '\bexclude' -or
            $Lower -match '\bignore' -or
            $Lower -match '\bguardrail' -or
            $Lower -match '\bchecklist' -or
            $Lower -match '\bstop\b' -or
            $Lower -match '\bencountered\b' -or
            $Lower -match '\bhandling credentials\b' -or
            $Lower -match '\bno secret'
        ) {
            return 'approved safety documentation or guardrail wording'
        }
    }

    if ($File.Name -eq 'audit-skills.ps1') {
        return 'audit rule definition'
    }

    return $null
}

$KeywordPattern = '(?i)(token|api[_-]?key|apikey|password|secret|\.' + 'env|credential file|private key)'
$ScanFiles = @()
$CandidateFiles = @(Get-ChildItem -LiteralPath $RepoRoot -Recurse -File -Force | Where-Object {
    $_.FullName -notlike '*\.git\*'
})

if ($Mode -eq 'Local' -and (Test-Path -LiteralPath $UserSkillMaker -PathType Leaf)) {
    $CandidateFiles += Get-Item -LiteralPath $UserSkillMaker
}

foreach ($File in $CandidateFiles | Sort-Object FullName -Unique) {
    if (Test-SensitiveFileName -File $File) {
        Add-Risk "Sensitive-looking file was not opened: $($File.FullName)"
        continue
    }

    if ($File.Extension -in @('.md', '.ps1') -or $File.Name -eq '.gitignore') {
        $ScanFiles += $File
    }
}

foreach ($File in $ScanFiles | Sort-Object FullName -Unique) {
    $Hits = Select-String -LiteralPath $File.FullName -Pattern $KeywordPattern -CaseSensitive:$false -ErrorAction SilentlyContinue
    foreach ($Hit in $Hits) {
        if (Test-SecretAssignmentLine -Line $Hit.Line) {
            Add-Risk "Possible secret assignment in $($Hit.Path): line $($Hit.LineNumber)"
            continue
        }

        $AllowedReason = Get-AllowedReferenceReason -File (Get-Item -LiteralPath $Hit.Path) -Line $Hit.Line
        if ($AllowedReason) {
            Add-AllowedReference "$($Hit.Path) ($AllowedReason)"
        } else {
            Add-Risk "Sensitive keyword candidate in $($Hit.Path): line $($Hit.LineNumber)"
        }
    }
}

if (-not ($Risk | Where-Object { $_ -like 'Possible secret*' -or $_ -like 'Sensitive keyword*' -or $_ -like 'Sensitive-looking file*' })) {
    Add-Pass 'No actual sensitive content risks found in audited files.'
}

if (Test-Path -LiteralPath $RepoSource -PathType Leaf) {
    Add-Pass "Repo Skill Maker source exists: $RepoSource"
} else {
    Add-Risk "Repo Skill Maker source is missing: $RepoSource"
}

if (Test-Path -LiteralPath $InstallScript -PathType Leaf) {
    Add-Pass "Install script exists: $InstallScript"
    $InstallText = Get-Content -LiteralPath $InstallScript -Raw -Encoding UTF8
    if (
        $InstallText -match '\[switch\]\$Install' -and
        $InstallText -match 'dry-run' -and
        $InstallText -match 'if\s*\(\s*-not\s+\$Install\.IsPresent\s*\)'
    ) {
        Add-Pass 'Install script defaults to dry-run unless -Install is provided.'
    } else {
        Add-Risk 'Install script dry-run default could not be verified.'
    }
} else {
    Add-Risk "Install script is missing: $InstallScript"
}

Add-Info "Repo root: $RepoRoot"
Add-Info "User-level Skill Maker path: $UserSkillMaker"

Write-Output 'Codex Skills audit summary'
Write-Output "Audit mode: $Mode"
Write-Output ''
Write-Output 'Pass items:'
foreach ($Item in $Pass) {
    Write-Output "PASS: $Item"
}

Write-Output ''
Write-Output 'Allowed references:'
if ($AllowedReference.Count -eq 0) {
    Write-Output 'ALLOWED_REFERENCE: none'
} else {
    foreach ($Group in ($AllowedReference | Group-Object | Sort-Object Name)) {
        Write-Output "ALLOWED_REFERENCE: $($Group.Name) [$($Group.Count) match(es)]"
    }
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

if ($Risk.Count -gt 0) {
    exit 1
}
