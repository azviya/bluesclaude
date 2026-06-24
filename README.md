# bluesclaude

Run [Claude Code](https://docs.claude.com/en/docs/claude-code) against [BluesMinds](https://bluesminds.com)'s Anthropic-compatible API.

Install once with a single command, enter your BluesMinds API key once (it asks you interactively if you haven't included it yet), and from then on just run `bluesclaude` — it sets the base URL/API key and launches `claude` for you.

> **Note:** Requires the `claude` CLI to already be installed ([instructions](https://docs.claude.com/en/docs/claude-code)).

## Install (one command)

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/azviya/bluesclaude/main/install.sh | bash
```

Installs a single `bluesclaude` script into `~/.local/bin`. If that directory isn't on your `PATH`, the installer prints the line to add.

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/azviya/bluesclaude/main/install.ps1 | iex
```

Installs `bluesclaude` into `%LOCALAPPDATA%\Programs\bluesclaude` and adds it to your user `PATH`. Open a **new** terminal afterward.

---

## Use

First run asks for your BluesMinds API key (hidden input) and saves it:

```bash
bluesclaude
```

Every run after that just works — same key, no prompt. Any arguments pass straight through to `claude`:

```bash
bluesclaude "refactor this module"
bluesclaude --help
```

### Ways to provide the key

The key is resolved in this order:

1. `bluesclaude config <KEY>` — set it inline, no prompt.
2. The stored config file — set on a previous run.
3. `BLUESMINDS_API_KEY` environment variable — used and saved for next time.
4. Interactive prompt — asked for automatically if none of the above is set.

## Manage your key
 
```bash
bluesclaude login             # log in with a new key (interactive prompt)
bluesclaude login <KEY>       # log in and save key without a prompt
bluesclaude logout            # log out and delete the stored key
bluesclaude reset             # same as logout
```
 
`config`, `set-key`, `change`, and `change-key` are accepted as aliases for `login`.

## Automatic Key Verification

If the API key you stored becomes invalid, expired, or runs out of credits, `bluesclaude` will automatically detect this before launching Claude Code and ask you if you'd like to update it. This prevents the CLI from getting stuck in endless retry/connection loops.

| Platform        | Where the key is stored                            |
| --------------- | -------------------------------------------------- |
| macOS / Linux   | `~/.config/bluesclaude/config` (perms `600`)       |
| Windows         | `%APPDATA%\bluesclaude\config` (ACL: you only)     |

It is stored in plaintext on your machine. Treat it like any other local credential.

## What it sets

```sh
ANTHROPIC_BASE_URL="https://api.bluesminds.com/v1"
ANTHROPIC_AUTH_TOKEN="<your BluesMinds API key>"
```

Then runs: `claude --dangerously-skip-permissions "$@"`

## Uninstall

**macOS / Linux**

```bash
rm ~/.local/bin/bluesclaude
rm -rf ~/.config/bluesclaude
```

**Windows (PowerShell)**

```powershell
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\Programs\bluesclaude"
Remove-Item -Recurse -Force "$env:APPDATA\bluesclaude"
```
