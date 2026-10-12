#!/usr/bin/env bash
# lib/compat.sh - Host compatibility gate.
#
# The security tools this toolkit wraps target the Debian/Kali family (apt, and
# packages that only exist in Debian/Kali repos). On any other distro this
# module offers to run the toolkit inside a lightweight Debian container
# instead of failing tool by tool. Each toolkit gets its own box that mounts
# only that toolkit, so a box always runs the tree it was launched from,
# wherever that lives on disk, and the tools installed in it persist.
#
# Source-only file. Do not execute directly.

if [[ -n "${PENTEST_COMPAT_LOADED:-}" ]]; then
    return 0
fi
PENTEST_COMPAT_LOADED=1

# Box configuration. Each toolkit gets its own box (pentest-<toolkit>) that
# mounts only that toolkit. One override:
#   PENTEST_BOX_NAME=<name>   force a specific box name
: "${PENTEST_BOX_IMAGE:=debian:stable-slim}"
: "${PENTEST_ENGAGEMENTS_DIR:=${HOME}/pentest-engagements}"

# Resolve the box name for a toolkit label: one box per toolkit by default.
_box_name() {
    local label="$1"
    if [[ -n "${PENTEST_BOX_NAME:-}" ]]; then
        printf '%s' "${PENTEST_BOX_NAME}"
        return 0
    fi
    local slug="${label,,}"
    slug="$(printf '%s' "${slug}" | tr -cs 'a-z0-9' '-')"
    slug="${slug#-}"; slug="${slug%-}"
    printf 'pentest-%s' "${slug:-toolkit}"
}

# --- detection --------------------------------------------------------------

# detect_distro_family [os_release_path]  -> "debian" or "other"
detect_distro_family() {
    local osr="${1:-${COMPAT_OS_RELEASE:-/etc/os-release}}"
    [[ -r "$osr" ]] || { echo "other"; return 0; }
    local info
    # shellcheck disable=SC1090
    info="$(. "$osr" 2>/dev/null; printf '%s %s' "${ID:-}" "${ID_LIKE:-}")"
    case " ${info} " in
        *" debian "*|*ubuntu*|*kali*|*parrot*|*mint*|*devuan*|*raspbian*|*pop*)
            echo "debian" ;;
        *)
            echo "other" ;;
    esac
}

# host_is_supported [os_release_path]  -> 0 when the host runs the tools natively
# shellcheck disable=SC2120
host_is_supported() {
    [[ "$(detect_distro_family "$@")" == "debian" ]]
}

# container_runtime  -> "podman", "docker" or "none" (podman preferred)
container_runtime() {
    if command -v podman >/dev/null 2>&1; then
        echo "podman"
    elif command -v docker >/dev/null 2>&1; then
        echo "docker"
    else
        echo "none"
    fi
}

# --- argument builders (pure, testable) -------------------------------------

# _box_create_args <name> <image> <toolkit_dir> <engagements_dir>
# Args to create the persistent, detached box for one toolkit. Host networking
# plus NET_RAW/NET_ADMIN are required for real scans and raw-socket tools.
_box_create_args() {
    local name="$1" image="$2" toolkit_dir="$3" engagements_dir="$4"
    # The :z suffix relabels the bind mounts for SELinux hosts (Fedora, Bazzite,
    # RHEL) so a rootless container can write to them. It is a no-op elsewhere.
    printf 'run -d --name %s --hostname %s --network host --cap-add NET_RAW --cap-add NET_ADMIN -v %s:/opt/toolkit:z -v %s:/root/pentest-engagements:z %s sleep infinity' \
        "$name" "$name" "$toolkit_dir" "$engagements_dir" "$image"
}

# _box_exec_args <name> <inner_script>
# Args to run the toolkit inside the already-running box. PENTEST_IN_BOX marks
# the nested run so the gate does not recurse; PENTEST_ENGAGEMENTS points the
# toolkit's output at the host-mounted directory.
_box_exec_args() {
    local name="$1" inner_script="$2"
    printf 'exec -it -e PENTEST_IN_BOX=1 -e PENTEST_ENGAGEMENTS=/root/pentest-engagements %s bash %s' \
        "$name" "$inner_script"
}

# --- orchestration ----------------------------------------------------------

# Seed a freshly created box with the essentials every toolkit needs, and
# optionally the Kali repositories for tools missing from Debian.
_box_seed() {
    local rt="$1" name="$2"
    log_step "Preparing the Debian box (first run, this is a one-time step)"
    "$rt" exec "$name" bash -lc '
        set -e
        export DEBIAN_FRONTEND=noninteractive
        apt-get update -qq
        apt-get install -y -qq --no-install-recommends \
            sudo git curl ca-certificates gnupg python3 python3-pip pipx >/dev/null
    ' || { log_error "Could not seed the box."; return 1; }

    if prompt_yesno "Add the Kali repositories to the box for fuller tool coverage?"; then
        "$rt" exec "$name" bash -lc '
            set -e
            export DEBIAN_FRONTEND=noninteractive
            install -m0755 -d /etc/apt/keyrings
            curl -fsSL https://archive.kali.org/archive-key.asc \
                | gpg --dearmor -o /etc/apt/keyrings/kali.gpg
            echo "deb [signed-by=/etc/apt/keyrings/kali.gpg] http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" \
                > /etc/apt/sources.list.d/kali.list
            apt-get update -qq
        ' || log_warn "Kali repositories could not be added; Debian packages only."
    fi
}

# Host path currently bind-mounted at /opt/toolkit in an existing box.
_box_mount_src() {
    local rt="$1" name="$2"
    "$rt" container inspect -f \
        '{{range .Mounts}}{{if eq .Destination "/opt/toolkit"}}{{.Source}}{{end}}{{end}}' \
        "$name" 2>/dev/null
}

# Ensure the toolkit's box exists, runs, and mounts the right tree; create,
# seed, or rebuild it as needed.
_box_ensure() {
    local rt="$1" name="$2" toolkit_dir="$3" engagements_dir="$4"
    mkdir -p "$engagements_dir"

    if "$rt" container inspect "$name" >/dev/null 2>&1; then
        if [[ "$(_box_mount_src "$rt" "$name")" == "$toolkit_dir" ]]; then
            if [[ "$("$rt" container inspect -f '{{.State.Running}}' "$name" 2>/dev/null)" != "true" ]]; then
                "$rt" start "$name" >/dev/null || { log_error "Could not start box '${name}'."; return 1; }
            fi
            return 0
        fi
        # Box exists but points at a different tree (repo moved, or a stale box
        # from the old shared-mount layout): rebuild it rather than silently
        # running the wrong code.
        log_warn "Box '${name}' mounts a different path; rebuilding it."
        "$rt" rm -f "$name" >/dev/null 2>&1
    fi

    log_info "Creating Debian box '${name}' from ${PENTEST_BOX_IMAGE}..."
    local args
    args="$(_box_create_args "$name" "$PENTEST_BOX_IMAGE" "$toolkit_dir" "$engagements_dir")"
    # shellcheck disable=SC2086
    "$rt" $args >/dev/null || { log_error "Could not create the box."; return 1; }
    _box_seed "$rt" "$name"
}

# enter_box <toolkit_dir> <entry_script> [label]
# Launch this toolkit inside its own Debian box, creating it if needed.
enter_box() {
    local toolkit_dir="$1" entry_script="${2:-run.sh}" label="${3:-}"
    local rt; rt="$(container_runtime)"
    if [[ "$rt" == "none" ]]; then
        log_error "No container runtime found. Install podman (recommended) or docker, then retry."
        return 1
    fi

    local toolkit_abs inner box
    toolkit_abs="$(cd "$toolkit_dir" && pwd -P)"
    inner="/opt/toolkit/${entry_script}"
    box="$(_box_name "${label:-$(basename "$toolkit_abs")}")"

    _box_ensure "$rt" "$box" "$toolkit_abs" "$PENTEST_ENGAGEMENTS_DIR" || return 1

    log_success "Entering '${box}' (${rt}). Results persist in ${PENTEST_ENGAGEMENTS_DIR}."
    local args
    args="$(_box_exec_args "$box" "$inner")"
    # shellcheck disable=SC2086
    exec "$rt" $args
}

# compat_gate <toolkit_dir> <entry_script> [toolkit_label]
# Called once at startup. Returns 0 to run natively; otherwise offers the box
# and, on acceptance, replaces the process with the containerised run.
compat_gate() {
    local toolkit_dir="$1" entry_script="${2:-run.sh}"
    local label="${3:-$(basename "$toolkit_dir")}"

    # Already inside the box, or on a supported host: run natively.
    [[ -n "${PENTEST_IN_BOX:-}" ]] && return 0
    host_is_supported && return 0

    local family; family="$(detect_distro_family)"
    log_warn "Your distro (${family}) is not a Debian/Kali family, which these tools target."
    log_info "${label} can run inside a lightweight Debian box (${PENTEST_BOX_IMAGE})."
    if [[ "$(container_runtime)" == "none" ]]; then
        log_error "No container runtime found. Install podman or docker to use this, or run on a Debian-based host."
        if ! prompt_yesno "Continue natively anyway (many tools will fail to install)?"; then
            exit 1
        fi
        return 0
    fi
    if prompt_yesno "Run ${label} in its Debian box now?"; then
        enter_box "$toolkit_dir" "$entry_script" "$label"   # replaces the process on success
        log_error "Could not enter the box; continuing natively."
    fi
    return 0
}
