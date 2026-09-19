#!/usr/bin/env bash
# lib/session.sh - Engagement workspace management.
#
# One engagement lives under a single timestamped workspace directory with
# loot/, output/ and logs/ subtrees. This module owns the filesystem layout
# and the run_logged wrapper that ties a tool invocation to both the workspace
# (captured output) and the logger (TASK header, ok/failed state).
#
# Requires lib/logger.sh to be sourced first (for _log_reset_stats and the
# log_* helpers). Source-only file; do not execute directly.

if [[ -n "${SANDEVISTAN_SESSION_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_SESSION_LOADED=1

# --- name helpers -----------------------------------------------------------

# Lowercase, collapse every run of non-alphanumeric characters to a single
# hyphen, and trim leading/trailing hyphens.
_slugify() {
    local s="${1,,}"
    s="${s//[^a-z0-9]/-}"
    while [[ "${s}" == *--* ]]; do s="${s//--/-}"; done
    s="${s#-}"; s="${s%-}"
    printf '%s' "${s}"
}

# Reject engagement names that could escape the workspace root.
_validate_session_name() {
    local name="$1"
    [[ -n "${name}" ]]                   || return 1
    [[ "${name}" != *".."* ]]            || return 1
    [[ "${name}" =~ ^[A-Za-z0-9._-]+$ ]] || return 1
    return 0
}

# --- workspace --------------------------------------------------------------

# session_init [name]
# Creates a fresh engagement workspace, opens its log file and resets the run
# counters held by the logger.
session_init() {
    local name="${1:-engagement}"
    if ! _validate_session_name "${name}"; then
        name="engagement"
    fi
    # Inside the shared box PENTEST_ENGAGEMENTS points at the host-mounted dir.
    : "${SANDEVISTAN_WORKSPACE_ROOT:=${PENTEST_ENGAGEMENTS:-${HOME}/sandevistan-engagements}}"

    local ts
    ts="$(date -u +%Y%m%d-%H%M%S)"
    SANDEVISTAN_WORKSPACE="${SANDEVISTAN_WORKSPACE_ROOT}/${name}-${ts}"
    mkdir -p "${SANDEVISTAN_WORKSPACE}/loot" \
             "${SANDEVISTAN_WORKSPACE}/output" \
             "${SANDEVISTAN_WORKSPACE}/logs"
    SANDEVISTAN_LOG_FILE="${SANDEVISTAN_WORKSPACE}/logs/session.log"
    : > "${SANDEVISTAN_LOG_FILE}"
    export SANDEVISTAN_WORKSPACE SANDEVISTAN_LOG_FILE

    _log_reset_stats
    _log_line "session start: ${name} (${SANDEVISTAN_WORKSPACE})"
}

session_dir() {
    printf '%s' "${SANDEVISTAN_WORKSPACE:-}"
}

# session_output_file <label>
# Prints a path under output/ for a tool's captured output, or nothing when
# no workspace is active.
session_output_file() {
    [[ -n "${SANDEVISTAN_WORKSPACE:-}" ]] || return 0
    local slug
    slug="$(_slugify "$1")"
    [[ -n "${slug}" ]] || slug="output"
    printf '%s/output/%s-%s.txt' \
        "${SANDEVISTAN_WORKSPACE}" "${slug}" "$(date -u +%H%M%S)"
}

# --- run wrapper ------------------------------------------------------------

# run_logged <task name> <command...>
# Prints a TASK header, runs the command (capturing its output into the
# workspace when one is active), records ok/failed and returns the command's
# own exit code. Use it for non-interactive tools; leave REPL/TUI tools alone.
run_logged() {
    local name="$1"; shift
    log_task "${name}"

    local out_file rc
    out_file="$(session_output_file "${name}")"
    if [[ -n "${out_file}" ]]; then
        "$@" 2>&1 | tee "${out_file}"
        rc=${PIPESTATUS[0]}
    else
        "$@"
        rc=$?
    fi

    if (( rc == 0 )); then
        log_ok "${name}"
    else
        log_failed "${name} (exit ${rc})"
    fi
    return "${rc}"
}
