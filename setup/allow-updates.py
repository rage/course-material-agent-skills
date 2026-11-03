# Lets Claude Code update this repository, and optionally a private skills repository,
# without asking: adds `Bash(git -C <repository> pull --ff-only)` to permissions.allow in
# settings.json. Run only after the teacher's yes; an agent must not widen its own permissions.
# Rules already present and every other setting are left alone. Refuses a settings file that
# isn't valid JSON. allow-updates.mjs does the same with Node; keep the two in step.
#
# Usage: python3 allow-updates.py [<private repository>]
import json
import os
import sys

IS_WINDOWS = sys.platform == "win32"


# The rule must match the command text as the update runs it: quoted when the path has
# spaces; on Windows, either slash and either shell.
def rules_for(directory):
    if not os.path.isdir(directory):
        sys.exit(f"{directory} isn't a folder.")
    absolute = os.path.realpath(directory)
    variants = [absolute.replace("\\", "/"), absolute] if IS_WINDOWS else [absolute]
    shells = ["Bash", "PowerShell"] if IS_WINDOWS else ["Bash"]
    rules = []
    for variant in variants:
        quoted = f'"{variant}"' if " " in variant else variant
        rules += [f"{shell}(git -C {quoted} pull --ff-only)" for shell in shells]
    return rules


repositories = [os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")]
if len(sys.argv) > 1 and sys.argv[1]:
    repositories.append(sys.argv[1])
rules = [rule for repository in repositories for rule in rules_for(repository)]

config_dir = os.environ.get("CLAUDE_CONFIG_DIR") or os.path.join(os.path.expanduser("~"), ".claude")
os.makedirs(config_dir, exist_ok=True)
file = os.path.join(config_dir, "settings.json")

settings = {}
if os.path.exists(file):
    try:
        with open(file, encoding="utf-8") as f:
            settings = json.load(f)
    except ValueError as error:
        sys.exit(f"{file} isn't valid JSON ({error}); left unchanged.")
allow = settings.setdefault("permissions", {}).setdefault("allow", [])

missing = [rule for rule in rules if rule not in allow]
if not missing:
    print("Already allowed")
    sys.exit(0)
allow += missing

temporary = f"{file}.{os.getpid()}.tmp"
try:
    with open(temporary, "w", encoding="utf-8", newline="\n") as f:
        f.write(json.dumps(settings, indent=2, ensure_ascii=False) + "\n")
    os.replace(temporary, file)
except BaseException:
    if os.path.exists(temporary):
        os.remove(temporary)
    raise
print(f"Added {len(missing)} rule(s) to {file}")
