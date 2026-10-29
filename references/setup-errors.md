# Setup errors

- **No courses.mooc.fi tools**: the server isn't connected or the teacher isn't signed in. In Claude Code they run `/mcp` and sign in to `courses-moocfi`; in Codex, `codex mcp login courses-moocfi`. If the server isn't configured at all, they paste the setup prompt from SETUP.md again.
- **A single tool missing**: the teacher didn't grant its permission at sign-in; they can sign in again or do that part in the web UI.
- **"Unsupported protocol version"**: in Codex the teacher runs `codex features enable mcp_2026_07_28` and starts a new session; in Claude Code they update Claude Code.
