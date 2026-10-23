#!/usr/bin/env bash
# Links each task skill in skills/ into a skills folder, for clients that only
# discover skills one level deep (Claude Code). Removes links to deleted
# task skills. Runs from the git post-merge hook.
#
# Usage: link-task-skills.sh <skills folder>
set -euo pipefail

skills_root="${1:?usage: link-task-skills.sh <skills folder>}"
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

mkdir -p "$skills_root"

for task_skill in "$repo_dir"/skills/*/; do
  [ -f "$task_skill/SKILL.md" ] || continue
  task_skill="${task_skill%/}"
  link="$skills_root/$(basename "$task_skill")"
  if [ -L "$link" ]; then
    [ "$(readlink "$link")" = "$task_skill" ] && continue
    rm "$link"
  elif [ -e "$link" ]; then
    echo "Skipping $link: it exists and isn't a link made by this setup." >&2
    continue
  fi
  ln -s "$task_skill" "$link"
done

for link in "$skills_root"/*; do
  [ -L "$link" ] || continue
  target="$(readlink "$link")"
  case "$target" in
    "$repo_dir"/skills/*)
      [ -e "$target/SKILL.md" ] || rm "$link"
      ;;
  esac
done
