#!/usr/bin/env bash
# Links each skill in a repository's skills/ into a skills folder, for clients that only
# discover skills one level deep (Claude Code). Removes links to deleted skills. Runs from
# the git post-merge hook. Leaves links into other repositories alone, so this repository
# and a teacher's private skills repository can't take each other's links.
#
# Usage: link-task-skills.sh <skills folder> [<repository>]
#   <repository> defaults to the one holding this script; old hooks pass only the folder.
set -euo pipefail

skills_root="${1:?usage: link-task-skills.sh <skills folder> [<repository>]}"
repo_dir="$(cd "${2:-$(dirname "${BASH_SOURCE[0]}")/..}" && pwd -P)"

mkdir -p "$skills_root"

for task_skill in "$repo_dir"/skills/*/; do
  [ -f "$task_skill/SKILL.md" ] || continue
  task_skill="${task_skill%/}"
  link="$skills_root/$(basename "$task_skill")"
  if [ -L "$link" ]; then
    target="$(readlink "$link")"
    [ "$target" = "$task_skill" ] && continue
    case "$target" in
      "$repo_dir"/skills/*) rm "$link" ;;
      *)
        echo "Skipping $link: it links to $target, another repository." >&2
        continue
        ;;
    esac
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
