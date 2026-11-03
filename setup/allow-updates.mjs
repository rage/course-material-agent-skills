// Lets Claude Code update this repository, and optionally a private skills repository,
// without asking: adds `Bash(git -C <repository> pull --ff-only)` to permissions.allow in
// settings.json. Run only after the teacher's yes; an agent must not widen its own permissions.
// Rules already present and every other setting are left alone. Refuses a settings file that
// isn't valid JSON. allow-updates.py does the same for machines with Python instead of Node;
// keep the two in step.
//
// Usage: node allow-updates.mjs [<private repository>]
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const isWindows = process.platform === "win32";

// The rule must match the command text as the update runs it: quoted when the path has
// spaces; on Windows, either slash and either shell.
function rulesFor(directory) {
  if (!fs.statSync(directory, { throwIfNoEntry: false })?.isDirectory()) {
    console.error(`${directory} isn't a folder.`);
    process.exit(1);
  }
  const absolute = fs.realpathSync(directory);
  const variants = isWindows ? [absolute.replaceAll("\\", "/"), absolute] : [absolute];
  const shells = isWindows ? ["Bash", "PowerShell"] : ["Bash"];
  return variants.flatMap((variant) => {
    const quoted = variant.includes(" ") ? `"${variant}"` : variant;
    return shells.map((shell) => `${shell}(git -C ${quoted} pull --ff-only)`);
  });
}

const repositories = [path.join(path.dirname(fileURLToPath(import.meta.url)), "..")];
if (process.argv[2]) repositories.push(process.argv[2]);
const rules = repositories.flatMap(rulesFor);

const configDir = process.env.CLAUDE_CONFIG_DIR || path.join(os.homedir(), ".claude");
fs.mkdirSync(configDir, { recursive: true });
const file = path.join(configDir, "settings.json");

let settings = {};
if (fs.existsSync(file)) {
  try {
    settings = JSON.parse(fs.readFileSync(file, "utf8"));
  } catch (error) {
    console.error(`${file} isn't valid JSON (${error.message}); left unchanged.`);
    process.exit(1);
  }
}
settings.permissions ??= {};
settings.permissions.allow ??= [];

const missing = rules.filter((rule) => !settings.permissions.allow.includes(rule));
if (missing.length === 0) {
  console.log("Already allowed");
  process.exit(0);
}
settings.permissions.allow.push(...missing);

const temporary = `${file}.${process.pid}.tmp`;
try {
  fs.writeFileSync(temporary, JSON.stringify(settings, null, 2) + "\n");
  fs.renameSync(temporary, file);
} catch (error) {
  fs.rmSync(temporary, { force: true });
  throw error;
}
console.log(`Added ${missing.length} rule(s) to ${file}`);
