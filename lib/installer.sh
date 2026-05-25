#!/usr/bin/env bash
# lib/installer.sh — reusable install/run helpers used by every module.
# Source-only file. Depends on lib/core.sh.

if [[ -n "${SANDEVISTAN_INSTALLER_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_INSTALLER_LOADED=1

[[ -z "${SANDEVISTAN_CORE_LOADED:-}" ]] && {
    echo "lib/installer.sh: lib/core.sh must be sourced first" >&2
    return 1
}

# ---------------------------------------------------------------------------
# Logging helpers
# ---------------------------------------------------------------------------

log_step()    { printf '\n%s[◆]%s %s\n\n' "${BRIGHT_RED}" "${RESET}" "$*"; }
log_info()    { printf '%s[i]%s %s\n'      "${BRIGHT_BLUE}" "${RESET}" "$*"; }
log_warn()    { printf '%s[!]%s %s\n'      "${BRIGHT_RED}"  "${RESET}" "$*" >&2; }
log_success() { printf '\n%s[✓]%s %s\n\n'  "${BRIGHT_GREEN}" "${RESET}" "$*"; }
log_error()   { printf '\n%s[✗]%s %s\n\n'  "${BRIGHT_RED}"   "${RESET}" "$*" >&2; }

# ---------------------------------------------------------------------------
# Prompts
# ---------------------------------------------------------------------------

# Yes/No prompt that accepts y, yes, Y, YES (any case). Returns 0 on yes.
prompt_yesno() {
    local message="$1" reply
    read -rp "${message} (yes/no): " reply
    [[ "${reply,,}" =~ ^(y|yes)$ ]]
}

# Read a value from the user, with an optional default.
# Usage: prompt_value "Question" "default"
prompt_value() {
    local message="$1" default="${2:-}" reply
    if [[ -n "$default" ]]; then
        read -rp "${message} (default: ${default}): " reply
        echo "${reply:-$default}"
    else
        read -rp "${message}: " reply
        echo "$reply"
    fi
}

# ---------------------------------------------------------------------------
# Privilege escalation wrapper
# ---------------------------------------------------------------------------

# Run a command with sudo if available, otherwise plain. Useful in containers.
maybe_sudo() {
    if [[ "$(id -u)" -eq 0 ]]; then
        "$@"
    elif command -v sudo >/dev/null 2>&1; then
        sudo "$@"
    else
        log_warn "sudo not available; running as current user."
        "$@"
    fi
}

# ---------------------------------------------------------------------------
# Backend installers
# ---------------------------------------------------------------------------

install_apt() {
    log_step "Installing via apt: $*"
    maybe_sudo apt-get update -qq
    maybe_sudo apt-get install -y "$@"
}

install_gem() {
    log_step "Installing gem(s): $*"
    maybe_sudo gem install "$@"
}

install_go() {
    local pkg="$1"
    if ! command -v go >/dev/null 2>&1; then
        log_warn "Go is required but not installed."
        if prompt_yesno "Install golang-go via apt now?"; then
            install_apt golang-go
        else
            return 1
        fi
    fi
    log_step "Installing Go package: ${pkg}"
    go install "${pkg}"
    export PATH="${PATH}:${HOME}/go/bin"
}

install_git() {
    local repo_url="$1" dest_dir="$2"
    mkdir -p "$(dirname "$dest_dir")"
    if [[ -d "$dest_dir/.git" ]]; then
        log_info "Already cloned at ${dest_dir}, pulling latest…"
        git -C "$dest_dir" pull --ff-only || true
    else
        log_step "Cloning ${repo_url} → ${dest_dir}"
        git clone --depth=1 "$repo_url" "$dest_dir"
    fi
}

install_pip_requirements() {
    local dir="$1"
    if [[ -f "${dir}/requirements.txt" ]]; then
        log_step "Installing Python dependencies from ${dir}/requirements.txt"
        if command -v pip3 >/dev/null 2>&1; then
            pip3 install --user -r "${dir}/requirements.txt"
        else
            log_error "pip3 not available; cannot install Python dependencies."
            return 1
        fi
    fi
}

# ---------------------------------------------------------------------------
# High-level "ensure tool is available" helpers
# ---------------------------------------------------------------------------

# ensure_command <cmd> <install_callback>
# If <cmd> is missing on PATH, prompts the user and runs <install_callback>.
# Returns 0 when the command is available afterwards, 1 otherwise.
ensure_command() {
    local cmd="$1" install_callback="$2"

    if command -v "$cmd" >/dev/null 2>&1; then
        return 0
    fi

    log_warn "${cmd} is not installed."
    if ! prompt_yesno "Would you like to install it?"; then
        log_info "Installation cancelled."
        return 1
    fi

    # shellcheck disable=SC2091
    $install_callback || {
        log_error "Installation of ${cmd} failed."
        return 1
    }

    if command -v "$cmd" >/dev/null 2>&1; then
        log_success "${cmd} installed successfully."
        return 0
    fi

    log_error "${cmd} still not on PATH after install."
    return 1
}

# ensure_repo <repo_url> <dest_dir> [post_install_callback]
# Ensures a git-based tool exists in <dest_dir>, optionally running a callback
# (e.g. installing dependencies) right after a fresh clone.
ensure_repo() {
    local repo_url="$1" dest_dir="$2" post_install_callback="${3:-}"

    if [[ -d "$dest_dir" ]]; then
        return 0
    fi

    log_warn "Repository not found at ${dest_dir}."
    if ! prompt_yesno "Clone ${repo_url}?"; then
        log_info "Installation cancelled."
        return 1
    fi

    install_git "$repo_url" "$dest_dir" || {
        log_error "git clone failed."
        return 1
    }

    if [[ -n "$post_install_callback" ]]; then
        # shellcheck disable=SC2091
        $post_install_callback || {
            log_error "Post-install step failed."
            return 1
        }
    fi

    log_success "Cloned to ${dest_dir}."
    return 0
}

# Run a command inside a directory without polluting the caller's CWD.
run_in_dir() {
    local dir="$1"; shift
    (cd "$dir" && "$@")
}
