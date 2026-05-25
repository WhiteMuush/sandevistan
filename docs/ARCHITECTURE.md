# Architecture

SANDEVISTAN is a bash script that wraps a curated set of offensive-security
tools behind a unified, cyberpunk-themed menu. The codebase favours
readability and **predictable extension points** over abstraction, so that
contributors can land their first tool integration with one focused PR.

## High-level layout

```
sandevistan.sh             ── thin entry point: sources the lib and starts the loop
└── lib/
    ├── core.sh            ── colors, constants, project metadata
    ├── ui.sh              ── ASCII art, banners, menu rendering helpers
    ├── installer.sh       ── prompts, logging, install/run helpers
    └── modules/
        ├── recon.sh
        ├── vulnerability.sh
        ├── exploitation.sh
        ├── postexploit.sh
        ├── credentials.sh
        └── payload.sh
```

Every file under `lib/` is **source-only** — it never runs by itself. The
entry point is the only executable script.

## Boot sequence

1. `sandevistan.sh` resolves its own directory into `SANDEVISTAN_ROOT`.
2. It sources, in order:
   - `lib/core.sh` (palette, constants)
   - `lib/ui.sh` (banners — depends on core)
   - `lib/installer.sh` (helpers — depends on core)
   - Every `lib/modules/*.sh` (depend on core + installer + ui)
3. `main_loop` runs an infinite read-render-dispatch loop until the user
   chooses *LEAVE*.

Each library is **idempotent**: a `SANDEVISTAN_<NAME>_LOADED` guard prevents
double-sourcing.

## The two install helpers

Almost every tool falls in one of two buckets, and `lib/installer.sh` exposes
one helper for each:

### `ensure_command <bin> <install_callback>`

For tools shipped as a binary on `PATH` (apt packages, Go binaries, gems,
distro-provided scripts).

```bash
ensure_command "nmap" "install_apt nmap" || return 0
nmap "$target"
```

The callback can be any shell expression. `install_apt`, `install_gem`,
`install_go` are pre-built helpers; you may also pass a custom function.

### `ensure_repo <repo_url> <dest_dir> [post_install_callback]`

For tools we clone from GitHub.

```bash
local dest="${SANDEVISTAN_TOOLS_DIR}/XSStrike"
ensure_repo \
    "https://github.com/s0md3v/XSStrike.git" \
    "$dest" \
    "install_pip_requirements ${dest}" || return 0
python3 "${dest}/xsstrike.py" -u "$target"
```

The optional third argument runs once, right after a fresh clone.

## Logging

Always use the log helpers from `lib/installer.sh` — they share a consistent
visual style and degrade gracefully when stdout is not a TTY (no color codes
in pipes/logs).

| Helper        | Meaning                                |
|---------------|----------------------------------------|
| `log_step`    | A major action begins                  |
| `log_info`    | Informational hint                     |
| `log_warn`    | Non-fatal warning                      |
| `log_error`   | Action failed                          |
| `log_success` | Action completed successfully          |

## User input helpers

| Helper                | Purpose                                            |
|-----------------------|----------------------------------------------------|
| `prompt_yesno "Q?"`   | Yes/No prompt; returns 0 on yes                    |
| `prompt_value "Q"`    | Read a value with no default                       |
| `prompt_value "Q" "d"`| Read a value with a default of `d`                 |
| `shell_prompt`        | Print the cyberpunk `user@nexus:~$` style prompt   |

For sensitive input (passwords), use `read -rsp` directly to avoid echo.

## Privilege escalation

Use `maybe_sudo <cmd...>` instead of hard-coding `sudo`. It runs as the
current user if already root, otherwise prefers `sudo`, and falls back to a
plain call (with a warning) if neither is available.

## Where tools are installed

External tools clone into `${SANDEVISTAN_TOOLS_DIR}` (defaults to
`~/tools`). Users can override by exporting the variable before launch:

```bash
export SANDEVISTAN_TOOLS_DIR=/opt/sandevistan-tools
./sandevistan.sh
```

## Adding a module

1. Create `lib/modules/<name>.sh`.
2. Open with the standard load guard:
   ```bash
   if [[ -n "${SANDEVISTAN_MODULE_<NAME>_LOADED:-}" ]]; then
       return 0
   fi
   SANDEVISTAN_MODULE_<NAME>_LOADED=1
   ```
3. Define one `<module>_run_<tool>` function per tool.
4. Define a `<module>_menu` dispatcher (use `draw_banner`, `render_options`,
   `shell_prompt`, `press_enter_to_continue`).
5. Wire it into `handle_selection` in `sandevistan.sh` and add an entry to
   the main menu in `lib/ui.sh`.
6. Document it in [README.md](../README.md).

## Testing

There is no test framework yet (the project is interactive by nature). The
CI runs three checks on every PR:

- `bash -n` syntax check on every `.sh` file
- `shellcheck -e SC1091 -e SC2034` (SC1091 = dynamic sources; SC2034 =
  unused exported color variables)
- A *smoke test* that sources the entire lib without running the loop and
  verifies the expected functions are registered.

If you want to add unit-level tests, [bats-core](https://github.com/bats-core/bats-core)
is the recommended framework — open an issue first to discuss the scope.
