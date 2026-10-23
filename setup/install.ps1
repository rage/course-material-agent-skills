# Sets up the courses.mooc.fi course material skills and MCP server for Claude Code or Codex
# on Windows.
#
#   irm https://raw.githubusercontent.com/rage/course-material-agent-skills/main/setup/install.ps1 | iex
#
# Parameters (all optional; the script asks for what it needs) when run as a file:
#   -Agent claude|codex   which agent to set up
#   -ServerUrl URL        MCP server (default https://courses.mooc.fi/api/v0/mcp)
#   -ServerName NAME      name of the MCP server in the agent (default courses-mooc-fi)
#   -Playwright yes|no    install playwright-cli for visual checks, or skip it
#   -Yes                  accept the defaults without asking
param(
  [string]$Agent = '',
  [string]$ServerUrl = 'https://courses.mooc.fi/api/v0/mcp',
  [string]$ServerName = 'courses-mooc-fi',
  [string]$Playwright = '',
  [switch]$Yes
)
$ErrorActionPreference = 'Stop'

$repoUrl = if ($env:COURSE_MATERIAL_SKILLS_REPO) { $env:COURSE_MATERIAL_SKILLS_REPO } else { 'https://github.com/rage/course-material-agent-skills.git' }
$branch = if ($env:COURSE_MATERIAL_SKILLS_BRANCH) { $env:COURSE_MATERIAL_SKILLS_BRANCH } else { 'main' }
$skillName = 'course-material'
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$userHome = if ($env:USERPROFILE) { $env:USERPROFILE } else { $HOME }

function Write-Step([string]$text) { Write-Host ''; Write-Host "== $text" -ForegroundColor Cyan }
# Throws rather than exits, so a run piped into iex doesn't close the teacher's window.
function Stop-Setup([string]$text) { throw $text }
function Test-Command([string]$name) { [bool](Get-Command $name -ErrorAction SilentlyContinue) }

function Read-Answer([string]$question, [string]$default) {
  if ($Yes) { Write-Host "$question $default"; return $default }
  $answer = Read-Host $question
  if ([string]::IsNullOrWhiteSpace($answer)) { return $default }
  return $answer.Trim()
}

function Confirm-Choice([string]$question, [string]$default) {
  return (Read-Answer "$question [$default]" $default) -match '^[Yy]'
}

# Native commands don't throw on a non-zero exit, and under the Stop preference Windows PowerShell
# can throw on their stderr output. Commands whose failure is fine are wrapped in try/catch instead.
function Invoke-Native([scriptblock]$command) {
  $ErrorActionPreference = 'Continue'
  & $command | Out-Host
  return ($LASTEXITCODE -eq 0)
}

function Write-TextFile([string]$path, [string]$text) {
  New-Item -ItemType Directory -Force -Path (Split-Path -Parent $path) | Out-Null
  [System.IO.File]::WriteAllText($path, $text, $utf8NoBom)
}

Write-Step 'Which agent do you use?'
if (-not $Agent) {
  Write-Host '  1) Claude Code'
  Write-Host '  2) Codex'
  $choice = Read-Answer 'Choose 1 or 2' ''
  switch -Regex ($choice) {
    '^(1|claude)' { $Agent = 'claude' }
    '^(2|codex)' { $Agent = 'codex' }
    default { Stop-Setup 'Choose 1 (Claude Code) or 2 (Codex).' }
  }
}
switch ($Agent) {
  'claude' { Write-Host 'Setting up for Claude Code.' }
  'codex' { Write-Host 'Setting up for Codex.' }
  default { Stop-Setup '-Agent must be claude or codex.' }
}

Write-Step 'Checking the programs this needs'
if (-not (Test-Command 'git')) { Stop-Setup 'Git isn''t installed. Install Git for Windows from https://git-scm.com/download/win, then run this again.' }
Write-Host 'git: found'
if ($Agent -eq 'claude') {
  if (-not (Test-Command 'claude')) { Stop-Setup 'Claude Code isn''t installed. See https://code.claude.com/docs/en/setup, then run this again.' }
  Write-Host "Claude Code: $(claude --version)"
  $claudeHome = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $userHome '.claude' }
  $skillsRoot = Join-Path $claudeHome 'skills'
} else {
  if (-not (Test-Command 'codex')) { Stop-Setup 'Codex isn''t installed. See https://learn.chatgpt.com/docs/quickstart, then run this again.' }
  Write-Host "Codex: $(codex --version)"
  $skillsRoot = Join-Path (Join-Path $userHome '.agents') 'skills'
  $codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $userHome '.codex' }
}
$skillDir = Join-Path $skillsRoot $skillName

Write-Step "Installing the skills in $skillDir"
New-Item -ItemType Directory -Force -Path $skillsRoot | Out-Null
if (Test-Path (Join-Path $skillDir '.git')) {
  $currentRemote = try { git -C $skillDir remote get-url origin 2>$null } catch { '' }
  if ($currentRemote -notmatch 'rage/course-material-agent-skills' -and $currentRemote -ne $repoUrl) {
    Stop-Setup "$skillDir holds another git repository ($currentRemote). Move it away and run this again."
  }
  if (-not (Invoke-Native { git -C $skillDir pull --ff-only })) {
    Stop-Setup "Couldn't update $skillDir. If you changed files there, move them away and run this again."
  }
} elseif (Test-Path $skillDir) {
  Stop-Setup "$skillDir already exists and isn't a copy of this repository. Move it away and run this again."
} else {
  if (-not (Invoke-Native { git clone --branch $branch $repoUrl $skillDir })) { Stop-Setup 'Downloading the skills failed.' }
}
Write-Host "Skill version $((Get-Content (Join-Path $skillDir 'VERSION') -Raw).Trim())"

if ($Agent -eq 'claude') {
  # Claude Code only finds skills one folder deep, so each task skill gets a junction next to the main skill.
  $linkScript = Join-Path $skillDir 'setup\link-task-skills.ps1'
  & $linkScript -SkillsRoot $skillsRoot
  $hookScript = ($linkScript -replace '\\', '/')
  $hookRoot = ($skillsRoot -replace '\\', '/')
  Write-TextFile (Join-Path $skillDir '.git\hooks\post-merge') "#!/bin/sh`nexec powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$hookScript`" -SkillsRoot `"$hookRoot`"`n"
  Write-Host "Linked the task skills into $skillsRoot."
}

Write-Step "Connecting $ServerName ($ServerUrl)"
if ($Agent -eq 'claude') {
  try { claude mcp remove --scope user $ServerName 2>$null | Out-Null } catch { }
  if (-not (Invoke-Native { claude mcp add --transport http --scope user $ServerName $ServerUrl })) { Stop-Setup 'Adding the MCP server to Claude Code failed.' }
  if (Confirm-Choice 'Sign in to courses.mooc.fi now? (Otherwise Claude Code asks when it first needs it.)' 'Y') {
    if (-not (Invoke-Native { claude mcp login $ServerName })) {
      Write-Host "Sign-in didn't finish. In Claude Code, run /mcp and choose $ServerName to sign in later."
    }
  }
} else {
  # The server speaks only MCP protocol 2026-07-28, which Codex supports behind this feature flag.
  if (-not (Invoke-Native { codex features enable mcp_2026_07_28 })) { Stop-Setup 'Enabling the newer MCP protocol in Codex failed.' }
  try { codex mcp remove $ServerName 2>$null | Out-Null } catch { }
  Write-Host 'Codex opens your browser to sign in to courses.mooc.fi.'
  if (-not (Invoke-Native { codex mcp add $ServerName --url $ServerUrl })) {
    Write-Host "Sign-in didn't finish. Run 'codex mcp login $ServerName' later."
  }
}

Write-Step 'Letting the agent update the skill without asking'
if ($Agent -eq 'claude') {
  $settingsFile = Join-Path $claudeHome 'settings.json'
  $settings = [pscustomobject]@{}
  if (Test-Path $settingsFile) {
    $text = Get-Content $settingsFile -Raw
    if ($text -and $text.Trim()) { $settings = $text | ConvertFrom-Json }
  }
  if (-not $settings.PSObject.Properties['permissions']) { $settings | Add-Member -NotePropertyName permissions -NotePropertyValue ([pscustomobject]@{}) }
  if (-not $settings.permissions.PSObject.Properties['allow']) { $settings.permissions | Add-Member -NotePropertyName allow -NotePropertyValue @() }
  # The agent may write the folder with either slash style and run git from Bash or PowerShell.
  $allow = @($settings.permissions.allow)
  foreach ($path in @($skillDir, ($skillDir -replace '\\', '/')) | Select-Object -Unique) {
    foreach ($tool in 'Bash', 'PowerShell') {
      $rule = "$tool(git -C $path pull --ff-only)"
      if ($allow -notcontains $rule) { $allow += $rule }
    }
  }
  $settings.permissions.allow = $allow
  Write-TextFile $settingsFile (($settings | ConvertTo-Json -Depth 32) + "`n")
  Write-Host "Added allow rules for 'git -C $skillDir pull --ff-only' to $settingsFile."
} else {
  $rulesFile = Join-Path (Join-Path $codexHome 'rules') 'course-material-agent-skills.rules'
  $escapedDir = $skillDir -replace '\\', '\\'
  $rules = @"
# Lets Codex update the courses.mooc.fi course material skill without asking.
prefix_rule(
    pattern = ["git", "-C", "$escapedDir", "pull", "--ff-only"],
    decision = "allow",
    justification = "Updates the course material skill",
)
"@
  Write-TextFile $rulesFile ($rules + "`n")
  $check = try { codex execpolicy check --rules $rulesFile -- git -C $skillDir pull --ff-only 2>$null } catch { '' }
  if ("$check" -match '"decision":"allow"') {
    Write-Host "Added $rulesFile."
  } else {
    Write-Host "Added $rulesFile, but Codex didn't confirm it. Codex may ask once per update."
  }
}

Write-Step 'Visual checks (optional)'
if (Test-Command 'playwright-cli') {
  Write-Host 'playwright-cli: found'
} else {
  if (-not $Playwright) {
    $Playwright = if (Confirm-Choice 'Install playwright-cli so the agent can check pages in a browser? It needs Node.js.' 'Y') { 'yes' } else { 'no' }
  }
  if ($Playwright -eq 'yes') {
    if (Test-Command 'npm') {
      if (-not (Invoke-Native { npm install -g '@playwright/cli@latest' })) { Write-Host 'Installing playwright-cli failed. The agent will skip visual checks.' }
    } else {
      Write-Host 'Node.js isn''t installed (https://nodejs.org). The agent will skip visual checks until playwright-cli is installed.'
    }
  }
}
$playwrightSkill = Join-Path $skillsRoot 'playwright-cli'
if ($Playwright -ne 'no' -and (Test-Command 'playwright-cli') -and -not (Test-Path $playwrightSkill)) {
  # playwright-cli writes its skill into the current folder, so install it in a scratch folder and copy it.
  $scratch = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
  New-Item -ItemType Directory -Path $scratch | Out-Null
  $layout = if ($Agent -eq 'claude') { 'claude' } else { 'agents' }
  $source = Join-Path $scratch ".$layout\skills\playwright-cli"
  Push-Location $scratch
  try { playwright-cli install "--skills=$layout" *> $null } catch { } finally { Pop-Location }
  if (Test-Path $source) {
    Copy-Item -Recurse $source $playwrightSkill
    Write-Host 'Installed the playwright-cli skill.'
  } else {
    Write-Host "Couldn't install the playwright-cli skill. The agent can still use 'playwright-cli --help'."
  }
  Remove-Item -Recurse -Force $scratch -ErrorAction SilentlyContinue
}

Write-Step 'Done'
$agentLabel = if ($Agent -eq 'claude') { 'Claude Code' } else { 'Codex' }
Write-Host "Start a new $agentLabel session and ask, for example:"
Write-Host '  "List my courses on courses.mooc.fi."'
