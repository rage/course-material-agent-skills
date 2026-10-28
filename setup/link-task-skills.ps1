# Links each skill in a repository's skills\ into a skills folder as a directory junction,
# for clients that only discover skills one level deep (Claude Code). Junctions need no
# administrator rights. Removes junctions to deleted skills. Runs from the git post-merge
# hook. Leaves links into other repositories alone, so this repository and a teacher's
# private skills repository can't take each other's links.
#
# Usage: link-task-skills.ps1 <skills folder> [<repository>]
#   <repository> defaults to the one holding this script; old hooks pass only the folder.
param(
  [Parameter(Mandatory = $true)][string]$SkillsRoot,
  [string]$RepoDir = (Join-Path $PSScriptRoot '..')
)
$ErrorActionPreference = 'Stop'

$repoDir = (Resolve-Path $RepoDir).Path
$taskSkillsDir = Join-Path $repoDir 'skills'
New-Item -ItemType Directory -Force -Path $SkillsRoot | Out-Null

function Get-LinkTarget([System.IO.FileSystemInfo]$item) {
  if ($item.LinkType) { return [string]($item.Target | Select-Object -First 1) }
  return $null
}

function Test-InTaskSkills([string]$target) {
  return $target.StartsWith($taskSkillsDir + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)
}

foreach ($taskSkill in Get-ChildItem -Directory -Path $taskSkillsDir -ErrorAction SilentlyContinue) {
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
    if (-not (Test-InTaskSkills $target)) {
      Write-Warning "Skipping ${link}: it links to $target, another repository."
      continue
    }
    $existing.Delete()
  }
  New-Item -ItemType Junction -Path $link -Target $taskSkill.FullName | Out-Null
}

foreach ($item in Get-ChildItem -Force -Path $SkillsRoot) {
  $target = Get-LinkTarget $item
  if ($target -and (Test-InTaskSkills $target) -and -not (Test-Path (Join-Path $target 'SKILL.md'))) {
    $item.Delete()
  }
}
