# Links each task skill in skills\ into a skills folder as a directory junction, for clients
# that only discover skills one level deep (Claude Code). Junctions need no administrator
# rights. Removes junctions to deleted task skills. Runs from the git post-merge hook.
#
# Usage: link-task-skills.ps1 <skills folder>
param(
  [Parameter(Mandatory = $true)][string]$SkillsRoot
)
$ErrorActionPreference = 'Stop'

$repoDir = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$taskSkillsDir = Join-Path $repoDir 'skills'
New-Item -ItemType Directory -Force -Path $SkillsRoot | Out-Null

function Get-LinkTarget([System.IO.FileSystemInfo]$item) {
  if ($item.LinkType) { return [string]($item.Target | Select-Object -First 1) }
  return $null
}

foreach ($taskSkill in Get-ChildItem -Directory -Path $taskSkillsDir) {
  if (-not (Test-Path (Join-Path $taskSkill.FullName 'SKILL.md'))) { continue }
  $link = Join-Path $SkillsRoot $taskSkill.Name
  if (Test-Path -LiteralPath $link) {
    $existing = Get-Item -LiteralPath $link -Force
    $target = Get-LinkTarget $existing
    if (-not $target) {
      Write-Warning "Skipping ${link}: it exists and isn't a link made by this setup."
      continue
    }
    if ($target -eq $taskSkill.FullName) { continue }
    $existing.Delete()
  }
  New-Item -ItemType Junction -Path $link -Target $taskSkill.FullName | Out-Null
}

foreach ($item in Get-ChildItem -Force -Path $SkillsRoot) {
  $target = Get-LinkTarget $item
  if ($target -and $target.StartsWith($taskSkillsDir, [System.StringComparison]::OrdinalIgnoreCase) -and -not (Test-Path (Join-Path $target 'SKILL.md'))) {
    $item.Delete()
  }
}
