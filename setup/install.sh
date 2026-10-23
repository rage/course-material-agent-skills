#!/usr/bin/env bash
# Sets up the courses.mooc.fi course material skills and MCP server for Claude Code or Codex
# on macOS and Linux.
#
#   curl -fsSL https://raw.githubusercontent.com/rage/course-material-agent-skills/main/setup/install.sh | bash
#
# Options (all optional; the script asks for what it needs):
#   --agent claude|codex     which agent to set up
#   --server-url URL         MCP server (default https://courses.mooc.fi/api/v0/mcp)
#   --server-name NAME       name of the MCP server in the agent (default courses-mooc-fi)
#   --playwright | --no-playwright
#                            install playwright-cli for visual checks, or skip it
#   --yes                    accept the defaults without asking
set -euo pipefail

repo_url="${COURSE_MATERIAL_SKILLS_REPO:-https://github.com/rage/course-material-agent-skills.git}"
branch="${COURSE_MATERIAL_SKILLS_BRANCH:-main}"
skill_name="course-material"
server_url="https://courses.mooc.fi/api/v0/mcp"
server_name="courses-mooc-fi"
agent=""
playwright_choice=""
assume_yes=false

while [ $# -gt 0 ]; do
  case "$1" in
    --agent) agent="${2:?--agent needs a value}"; shift 2 ;;
    --server-url) server_url="${2:?--server-url needs a value}"; shift 2 ;;
    --server-name) server_name="${2:?--server-name needs a value}"; shift 2 ;;
    --playwright) playwright_choice=yes; shift ;;
    --no-playwright) playwright_choice=no; shift ;;
    --yes|-y) assume_yes=true; shift ;;
    -h|--help) echo "Options: --agent claude|codex, --server-url URL, --server-name NAME, --playwright, --no-playwright, --yes"; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

say() { printf '%s\n' "$*"; }
step() { printf '\n== %s\n' "$*"; }
fail() { printf 'Error: %s\n' "$*" >&2; exit 1; }
has() { command -v "$1" >/dev/null 2>&1; }

# Reads from the terminal so the script also works when piped into bash.
ask() {
  local question="$1" default="$2" answer=""
  if $assume_yes || ! { : </dev/tty; } 2>/dev/null; then
    printf '%s %s\n' "$question" "$default"
    REPLY="$default"
    return
  fi
  printf '%s ' "$question" >/dev/tty
  read -r answer </dev/tty || true
  REPLY="${answer:-$default}"
}

ask_yes_no() {
  ask "$1 [${2}]" "$2"
  case "$REPLY" in [Yy]*) return 0 ;; *) return 1 ;; esac
}

step "Which agent do you use?"
if [ -z "$agent" ]; then
  say "  1) Claude Code"
  say "  2) Codex"
  ask "Choose 1 or 2:" ""
  case "$REPLY" in
    1|claude|Claude*) agent=claude ;;
    2|codex|Codex) agent=codex ;;
    *) fail "Choose 1 (Claude Code) or 2 (Codex)." ;;
  esac
fi
case "$agent" in
  claude) say "Setting up for Claude Code." ;;
  codex) say "Setting up for Codex." ;;
  *) fail "--agent must be claude or codex." ;;
esac

step "Checking the programs this needs"
has git || fail "git isn't installed. Install it (macOS: run 'xcode-select --install'; Linux: your package manager), then run this again."
say "git: found"
if [ "$agent" = claude ]; then
  has claude || fail "Claude Code isn't installed. See https://code.claude.com/docs/en/setup, then run this again."
  say "Claude Code: $(claude --version 2>/dev/null || echo found)"
  skills_root="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills"
else
  has codex || fail "Codex isn't installed. See https://learn.chatgpt.com/docs/quickstart, then run this again."
  say "Codex: $(codex --version 2>/dev/null || echo found)"
  skills_root="$HOME/.agents/skills"
  codex_home="${CODEX_HOME:-$HOME/.codex}"
fi
skill_dir="$skills_root/$skill_name"

step "Installing the skills in $skill_dir"
mkdir -p "$skills_root"
if [ -d "$skill_dir/.git" ]; then
  current_remote="$(git -C "$skill_dir" remote get-url origin 2>/dev/null || true)"
  case "$current_remote" in
    *rage/course-material-agent-skills*|"$repo_url") ;;
    *) fail "$skill_dir holds another git repository ($current_remote). Move it away and run this again." ;;
  esac
  git -C "$skill_dir" pull --ff-only || fail "Couldn't update $skill_dir. If you changed files there, move them away and run this again."
elif [ -e "$skill_dir" ]; then
  fail "$skill_dir already exists and isn't a copy of this repository. Move it away and run this again."
else
  git clone --branch "$branch" "$repo_url" "$skill_dir"
fi
say "Skill version $(cat "$skill_dir/VERSION")"

if [ "$agent" = claude ]; then
  # Claude Code only finds skills one folder deep, so each task skill gets a link next to the main skill.
  bash "$skill_dir/setup/link-task-skills.sh" "$skills_root"
  hook="$skill_dir/.git/hooks/post-merge"
  printf '#!/bin/sh\nexec bash "$(git rev-parse --show-toplevel)/setup/link-task-skills.sh" %s\n' "'$skills_root'" >"$hook"
  chmod +x "$hook"
  say "Linked the task skills into $skills_root."
fi

step "Connecting $server_name ($server_url)"
if [ "$agent" = claude ]; then
  claude mcp remove --scope user "$server_name" >/dev/null 2>&1 || true
  claude mcp add --transport http --scope user "$server_name" "$server_url"
  if ask_yes_no "Sign in to courses.mooc.fi now? (Otherwise Claude Code asks when it first needs it.)" "Y"; then
    claude mcp login "$server_name" || say "Sign-in didn't finish. In Claude Code, run /mcp and choose $server_name to sign in later."
  fi
else
  # The server speaks only MCP protocol 2026-07-28, which Codex supports behind this feature flag.
  codex features enable mcp_2026_07_28
  codex mcp remove "$server_name" >/dev/null 2>&1 || true
  say "Codex opens your browser to sign in to courses.mooc.fi."
  codex mcp add "$server_name" --url "$server_url" || say "Sign-in didn't finish. Run 'codex mcp login $server_name' later."
fi

step "Letting the agent update the skill without asking"
update_command="git -C $skill_dir pull --ff-only"
if [ "$agent" = claude ]; then
  settings_file="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/settings.json"
  rule="Bash($update_command)"
  if has python3; then
    python3 - "$settings_file" "$rule" <<'PY'
import json, os, sys
path, rule = sys.argv[1], sys.argv[2]
settings = {}
if os.path.exists(path):
    with open(path, encoding="utf-8") as f:
        text = f.read().strip()
    settings = json.loads(text) if text else {}
allow = settings.setdefault("permissions", {}).setdefault("allow", [])
if rule not in allow:
    allow.append(rule)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(settings, f, indent=2)
        f.write("\n")
PY
    say "Added an allow rule for '$update_command' to $settings_file."
  else
    say "python3 isn't available, so the allow rule wasn't added. Claude Code will ask once per update;"
    say "choose \"Yes, and don't ask again\" to allow '$update_command'."
  fi
else
  rules_dir="$codex_home/rules"
  rules_file="$rules_dir/course-material-agent-skills.rules"
  mkdir -p "$rules_dir"
  cat >"$rules_file" <<EOF
# Lets Codex update the courses.mooc.fi course material skill without asking.
prefix_rule(
    pattern = ["git", "-C", "$skill_dir", "pull", "--ff-only"],
    decision = "allow",
    justification = "Updates the course material skill",
)
EOF
  if codex execpolicy check --rules "$rules_file" -- git -C "$skill_dir" pull --ff-only 2>/dev/null | grep -q '"allow"'; then
    say "Added $rules_file."
  else
    say "Added $rules_file, but Codex didn't confirm it. Codex may ask once per update."
  fi
fi

step "Visual checks (optional)"
if has playwright-cli; then
  say "playwright-cli: found"
else
  if [ -z "$playwright_choice" ]; then
    if ask_yes_no "Install playwright-cli so the agent can check pages in a browser? It needs Node.js." "Y"; then
      playwright_choice=yes
    else
      playwright_choice=no
    fi
  fi
  if [ "$playwright_choice" = yes ]; then
    if has npm; then
      npm install -g @playwright/cli@latest || say "Installing playwright-cli failed. The agent will skip visual checks."
    else
      say "Node.js isn't installed (https://nodejs.org). The agent will skip visual checks until playwright-cli is installed."
    fi
  fi
fi
if [ "$playwright_choice" != no ] && has playwright-cli && [ ! -e "$skills_root/playwright-cli" ]; then
  # playwright-cli writes its skill into the current folder, so install it in a scratch folder and copy it.
  scratch="$(mktemp -d)"
  if [ "$agent" = claude ]; then skill_layout=claude; skill_source="$scratch/.claude/skills/playwright-cli"; else skill_layout=agents; skill_source="$scratch/.agents/skills/playwright-cli"; fi
  if (cd "$scratch" && playwright-cli install --skills="$skill_layout" >/dev/null 2>&1) && [ -d "$skill_source" ] \
    && cp -R "$skill_source" "$skills_root/playwright-cli" && chmod -R u+w "$skills_root/playwright-cli"; then
    say "Installed the playwright-cli skill."
  else
    say "Couldn't install the playwright-cli skill. The agent can still use 'playwright-cli --help'."
  fi
  chmod -R u+w "$scratch" 2>/dev/null || true
  rm -rf "$scratch"
fi

step "Done"
say "Start a new $( [ "$agent" = claude ] && echo "Claude Code" || echo "Codex" ) session and ask, for example:"
say "  \"List my courses on courses.mooc.fi.\""
