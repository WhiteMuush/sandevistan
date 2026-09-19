#!/usr/bin/env bash
# lib/compat.sh - Host compatibility gate.
#
# The security tools SANDEVISTAN wraps target the Debian/Kali family (apt, and
# packages that only exist in Debian/Kali repos). On any other distro this
# module offers to run the toolkit inside a single, shared, lightweight Debian
# container instead of failing tool by tool. The same container (name and
# image are configurable) is reused by every toolkit under the same parent
# directory, so it is built once and the tools installed in it persist.
#
# Source-only file. Do not execute directly.

if [[ -n "${SANDEVISTAN_COMPAT_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_COMPAT_LOADED=1

# Shared box defaults. Override via the environment to point several toolkits
# at the same box, or to pick a heavier image (e.g. kalilinux/kali-rolling).
: "${PENTEST_BOX_NAME:=pentest-toolbox}"
: "${PENTEST_BOX_IMAGE:=debian:stable-slim}"
: "${PENTEST_ENGAGEMENTS_DIR:=${HOME}/pentest-engagements}"

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

# _box_create_args <name> <image> <toolkits_dir> <engagements_dir>
# Args to create the persistent, detached shared box. Host networking plus
# NET_RAW/NET_ADMIN are required for real scans and raw-socket tools.
_box_create_args() {
    local name="$1" image="$2" toolkits_dir="$3" engagements_dir="$4"
    # The :z suffix relabels the bind mounts for SELinux hosts (Fedora, Bazzite,
    # RHEL) so a rootless container can write to them. It is a no-op elsewhere.
    printf 'run -d --name %s --hostname %s --network host --cap-add NET_RAW --cap-add NET_ADMIN -v %s:/opt/toolkits:z -v %s:/root/pentest-engagements:z %s sleep infinity' \
        "$name" "$name" "$toolkits_dir" "$engagements_dir" "$image"
}

# _box_exec_args <name> <inner_script>
# Args to run a toolkit inside the already-running box.
_box_exec_args() {
    local name="$1" inner_script="$2"
    printf 'exec -it -e SANDEVISTAN_IN_BOX=1 -e SANDEVISTAN_WORKSPACE_ROOT=/root/pentest-engagements %s bash %s' \
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

# Ensure the shared box exists and is running; create and seed it on first use.
_box_ensure() {
    local rt="$1" name="$2" toolkits_dir="$3" engagements_dir="$4"
    mkdir -p "$engagements_dir"

    if "$rt" container inspect "$name" >/dev/null 2>&1; then
        if [[ "$("$rt" container inspect -f '{{.State.Running}}' "$name" 2>/dev/null)" != "true" ]]; then
            "$rt" start "$name" >/dev/null || { log_error "Could not start box '${name}'."; return 1; }
        fi
        return 0
    fi

    log_info "Creating shared Debian box '${name}' from ${PENTEST_BOX_IMAGE}..."
    local args
    args="$(_box_create_args "$name" "$PENTEST_BOX_IMAGE" "$toolkits_dir" "$engagements_dir")"
    # shellcheck disable=SC2086
    "$rt" $args >/dev/null || { log_error "Could not create the box."; return 1; }
    _box_seed "$rt" "$name"
}

# enter_box <toolkit_dir>
# Launch this toolkit inside the shared Debian box, creating it if needed.
enter_box() {
    local toolkit_dir="$1"
    local rt; rt="$(container_runtime)"
    if [[ "$rt" == "none" ]]; then
        log_error "No container runtime found. Install podman (recommended) or docker, then retry."
        return 1
    fi

    local toolkits_dir toolkit_name inner
    toolkits_dir="$(cd "$(dirname "$toolkit_dir")" && pwd -P)"
    toolkit_name="$(basename "$toolkit_dir")"
    inner="/opt/toolkits/${toolkit_name}/sandevistan.sh"

    _box_ensure "$rt" "$PENTEST_BOX_NAME" "$toolkits_dir" "$PENTEST_ENGAGEMENTS_DIR" || return 1

    log_success "Entering '${PENTEST_BOX_NAME}' (${rt}). Results persist in ${PENTEST_ENGAGEMENTS_DIR}."
    local args
    args="$(_box_exec_args "$PENTEST_BOX_NAME" "$inner")"
    # shellcheck disable=SC2086
    exec "$rt" $args
}

# compat_gate <toolkit_dir>
# Called once at startup. Returns 0 to run natively; otherwise offers the box
# and, on acceptance, replaces the process with the containerised run.
compat_gate() {
    local toolkit_dir="$1"

    # Already inside the box, or on a supported host: run natively.
    [[ -n "${SANDEVISTAN_IN_BOX:-}" ]] && return 0
    host_is_supported && return 0

    local family; family="$(detect_distro_family)"
    log_warn "Your distro (${family}) is not a Debian/Kali family, which these tools target."
    log_info "SANDEVISTAN can run inside a shared lightweight Debian box (${PENTEST_BOX_IMAGE})."
    if [[ "$(container_runtime)" == "none" ]]; then
        log_error "No container runtime found. Install podman or docker to use this, or run on a Debian-based host."
        if ! prompt_yesno "Continue natively anyway (many tools will fail to install)?"; then
            exit 1
        fi
        return 0
    fi
    if prompt_yesno "Run SANDEVISTAN in the shared Debian box now?"; then
        enter_box "$toolkit_dir"   # replaces the process on success
        log_error "Could not enter the box; continuing natively."
    fi
    return 0
}
