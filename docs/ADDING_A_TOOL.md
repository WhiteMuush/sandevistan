# Adding a Tool

This is the *one* recipe to follow when you want to integrate a new
offensive-security tool into SANDEVISTAN. If you're new to the codebase,
read [ARCHITECTURE.md](ARCHITECTURE.md) first.

A tool integration is almost always **one PR**, touching **one module
file**, **one line in the main entry**, and **one section of the README**.

---

## Step 1 — Pick the right module

Find which `lib/modules/<name>.sh` your tool belongs to:

| Category                          | File                       |
|-----------------------------------|----------------------------|
| Network discovery, enumeration    | `recon.sh`                 |
| Vulnerability scanners            | `vulnerability.sh`         |
| Exploitation frameworks           | `exploitation.sh`          |
| Post-exploitation, privesc, lateral | `postexploit.sh`         |
| Cracking, brute-force, spraying   | `credentials.sh`           |
| Payload generation / obfuscation  | `payload.sh`               |

If none fits, open a *Tool integration request* issue first so we can
discuss whether a new module is warranted.

---

## Step 2 — Pick the install strategy

There are two installation patterns. Pick the one that matches how the
tool's upstream distributes it:

### Pattern A — binary on PATH (apt / gem / go install / brew / …)

Use `ensure_command`:

```bash
recon_run_feroxbuster() {
    ensure_command "feroxbuster" "install_apt feroxbuster" || return 0
    local target
    target=$(prompt_value "Enter target URL")
    [[ -z "$target" ]] && { log_warn "URL is required."; return 0; }
    log_step "Running feroxbuster on ${target}"
    feroxbuster --url "$target"
}
```

You can chain installers if needed:

```bash
ensure_command "rustscan" "install_go github.com/RustScan/RustScan/cmd/rustscan@latest" || return 0
```

### Pattern B — git-cloned tool

Use `ensure_repo`. Pass an optional post-install callback to install Python
deps, run a build script, etc.

```bash
postexploit_run_kerbrute() {
    local dest="${SANDEVISTAN_TOOLS_DIR}/kerbrute"
    ensure_repo \
        "https://github.com/ropnop/kerbrute.git" \
        "$dest" \
        "run_in_dir ${dest} make" || return 0

    "${dest}/dist/kerbrute_linux_amd64" --help
}
```

Available post-install helpers:

- `install_pip_requirements "$dest"` — `pip3 install -r $dest/requirements.txt`
- `install_apt pkg1 pkg2 …`
- `install_gem gem1 gem2 …`
- `install_go pkg@version`
- `run_in_dir "$dest" <command>` — run something inside the clone

---

## Step 3 — Wire it into the menu

Each module ends with a `case` dispatcher. Add your tool there and bump the
options list at the top:

```bash
local options=(
    "1) Nmap"
    "2) Masscan"
    # …
    "10) feroxbuster"   # ← new
    "99) Back to Main Menu"
)

# …

case "$sub_choice" in
    1)  recon_run_nmap ;;
    # …
    10) recon_run_feroxbuster ;;   # ← new
    99) log_step "Returning to Main Menu"; sleep 1; clear; return ;;
    *)  log_warn "Invalid selection"; sleep 1; clear; return ;;
esac
```

---

## Step 4 — Update documentation

- Add the tool to the matching section of [README.md](../README.md).
- If the tool needs special prerequisites (e.g., a kernel module, a
  database), mention it next to the link.

---

## Step 5 — Validate locally

```bash
bash -n lib/modules/<name>.sh
shellcheck lib/modules/<name>.sh

# Smoke-test that the module still sources cleanly
bash -c '
    export SANDEVISTAN_ROOT="$PWD"
    source ./lib/core.sh
    source ./lib/ui.sh
    source ./lib/installer.sh
    for m in ./lib/modules/*.sh; do source "$m"; done
    declare -F recon_run_feroxbuster
'
```

Then run `./sandevistan.sh`, navigate to your menu entry, and confirm the
install + execution paths work.

---

## Step 6 — Open the PR

Use the PR template. The reviewer will check:

- Naming follows `<module>_run_<tool>` convention
- Either `ensure_command` or `ensure_repo` is used (no reinvented prompts)
- No hard-coded targets, credentials or paths
- Upstream license is compatible with MIT
- README updated

---

## Anti-patterns to avoid

| Don't…                                        | Do…                                               |
|-----------------------------------------------|---------------------------------------------------|
| `if ! command -v foo; then echo …; read …`    | `ensure_command "foo" "install_apt foo"`          |
| `cd ~/tools/foo && ./bar && cd -`             | `run_in_dir "$dest" ./bar`                        |
| `sudo apt-get install -y foo`                 | `install_apt foo` (handles sudo + update)         |
| `echo -e "${BRIGHT_RED}[!]…"`                 | `log_warn "…"`                                    |
| `read -rp "Enter X: " x`                      | `x=$(prompt_value "Enter X")`                     |
| `$(whoami)` as a variable name                | `username=$(prompt_value "Enter username")`       |
