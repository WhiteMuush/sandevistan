#!/usr/bin/env bash
# lib/session.sh - Engagement workspace and Ansible-style run logging.
#
# One engagement lives under a single timestamped workspace directory with
# loot/, output/ and logs/ subtrees. Activity is reported on screen in the
# familiar Ansible layout (TASK / PLAY headers, ok/changed/failed/skipped
# states and a PLAY RECAP) and mirrored, without colours, to logs/session.log.
#
# Source-only file. Do not execute directly.

if [[ -n "${SANDEVISTAN_SESSION_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_SESSION_LOADED=1

# Width used to pad TASK/PLAY header lines with trailing stars, like Ansible.
readonly _SESSION_LINE_WIDTH=79

# --- statistics -------------------------------------------------------------

_session_reset_stats() {
    SANDEVISTAN_STAT_TASKS=0
    SANDEVISTAN_STAT_OK=0
    SANDEVISTAN_STAT_CHANGED=0
    SANDEVISTAN_STAT_FAILED=0
    SANDEVISTAN_STAT_SKIPPED=0
    SANDEVISTAN_STAT_UNREACHABLE=0
}

# --- string helpers ---------------------------------------------------------

# Lowercase, collapse every run of non-alphanumeric characters to a single
# hyphen, and trim leading/trailing hyphens.
_slugify() {
    local s="${1,,}"
    s="${s//[^a-z0-9]/-}"
    while [[ "${s}" == *--* ]]; do s="${s//--/-}"; done
    s="${s#-}"; s="${s%-}"
    printf '%s' "${s}"
}

# Remove ANSI colour/escape sequences from a string.
_strip_ansi() {
    printf '%s' "$1" | sed -E 's/\x1b\[[0-9;]*m//g'
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
# Creates a fresh engagement workspace and opens its log file.
session_init() {
    local name="${1:-engagement}"
    if ! _validate_session_name "${name}"; then
        name="engagement"
    fi
    : "${SANDEVISTAN_WORKSPACE_ROOT:=${HOME}/sandevistan-engagements}"

    local ts
    ts="$(date -u +%Y%m%d-%H%M%S)"
    SANDEVISTAN_WORKSPACE="${SANDEVISTAN_WORKSPACE_ROOT}/${name}-${ts}"
    mkdir -p "${SANDEVISTAN_WORKSPACE}/loot" \
             "${SANDEVISTAN_WORKSPACE}/output" \
             "${SANDEVISTAN_WORKSPACE}/logs"
    SANDEVISTAN_LOG_FILE="${SANDEVISTAN_WORKSPACE}/logs/session.log"
    : > "${SANDEVISTAN_LOG_FILE}"
    export SANDEVISTAN_WORKSPACE SANDEVISTAN_LOG_FILE

    _session_reset_stats
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

# --- emitters ---------------------------------------------------------------

# Append a timestamped, colour-free line to the session log when one is open.
_log_line() {
    [[ -n "${SANDEVISTAN_LOG_FILE:-}" ]] || return 0
    printf '[%s] %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$(_strip_ansi "$1")" \
        >> "${SANDEVISTAN_LOG_FILE}"
}

# Print a coloured line to stdout and mirror the plain text to the log file.
_emit() {
    printf '%b\n' "$1"
    _log_line "${2:-$1}"
}

# Pad a header prefix with trailing stars up to the fixed line width.
_pad_stars() {
    local prefix="$1"
    local len=$(( _SESSION_LINE_WIDTH - ${#prefix} - 1 ))
    (( len < 3 )) && len=3
    local stars
    printf -v stars '%*s' "${len}" ''
    printf '%s' "${stars// /*}"
}

# --- headers ----------------------------------------------------------------

log_play() {
    local name="$1"
    local prefix="PLAY [${name}]"
    _emit "${BOLD}${prefix}${RESET} ${GRAY}$(_pad_stars "${prefix}")${RESET}" \
          "${prefix} $(_pad_stars "${prefix}")"
}

log_task() {
    local name="$1"
    SANDEVISTAN_STAT_TASKS=$(( ${SANDEVISTAN_STAT_TASKS:-0} + 1 ))
    local prefix="TASK [${name}]"
    _emit "${BOLD}${prefix}${RESET} ${GRAY}$(_pad_stars "${prefix}")${RESET}" \
          "${prefix} $(_pad_stars "${prefix}")"
}

# --- states -----------------------------------------------------------------

log_ok() {
    SANDEVISTAN_STAT_OK=$(( ${SANDEVISTAN_STAT_OK:-0} + 1 ))
    _emit "${GREEN}ok:${RESET} $1" "ok: $1"
}

log_changed() {
    SANDEVISTAN_STAT_CHANGED=$(( ${SANDEVISTAN_STAT_CHANGED:-0} + 1 ))
    _emit "${YELLOW}changed:${RESET} $1" "changed: $1"
}

log_failed() {
    SANDEVISTAN_STAT_FAILED=$(( ${SANDEVISTAN_STAT_FAILED:-0} + 1 ))
    _emit "${BRIGHT_RED}failed:${RESET} $1" "failed: $1"
}

log_skipped() {
    SANDEVISTAN_STAT_SKIPPED=$(( ${SANDEVISTAN_STAT_SKIPPED:-0} + 1 ))
    _emit "${CYAN}skipping:${RESET} $1" "skipping: $1"
}

log_unreachable() {
    SANDEVISTAN_STAT_UNREACHABLE=$(( ${SANDEVISTAN_STAT_UNREACHABLE:-0} + 1 ))
    _emit "${BRIGHT_RED}unreachable:${RESET} $1" "unreachable: $1"
}

# --- recap ------------------------------------------------------------------

log_recap() {
    local host="${SANDEVISTAN_SESSION_TARGET:-localhost}"
    local ok="${SANDEVISTAN_STAT_OK:-0}"
    local changed="${SANDEVISTAN_STAT_CHANGED:-0}"
    local unreachable="${SANDEVISTAN_STAT_UNREACHABLE:-0}"
    local failed="${SANDEVISTAN_STAT_FAILED:-0}"
    local skipped="${SANDEVISTAN_STAT_SKIPPED:-0}"

    local header="PLAY RECAP"
    _emit "${BOLD}${header}${RESET} ${GRAY}$(_pad_stars "${header}")${RESET}" \
          "${header} $(_pad_stars "${header}")"

    # Colour a count only when it is non-zero, like Ansible does.
    local c_changed="ok" c_failed="ok" c_unreach="ok"
    (( changed > 0 ))     && c_changed="${YELLOW}"
    (( failed > 0 ))      && c_failed="${BRIGHT_RED}"
    (( unreachable > 0 )) && c_unreach="${BRIGHT_RED}"
    [[ "${c_changed}" == "ok" ]] && c_changed=""
    [[ "${c_failed}" == "ok" ]]  && c_failed=""
    [[ "${c_unreach}" == "ok" ]] && c_unreach=""

    local console plain
    plain="$(printf '%-24s : ok=%d changed=%d unreachable=%d failed=%d skipped=%d' \
        "${host}" "${ok}" "${changed}" "${unreachable}" "${failed}" "${skipped}")"
    console="$(printf '%-24s : %sok=%d%s %schanged=%d%s %sunreachable=%d%s %sfailed=%d%s skipped=%d' \
        "${host}" \
        "${GREEN}" "${ok}" "${RESET}" \
        "${c_changed}" "${changed}" "${RESET}" \
        "${c_unreach}" "${unreachable}" "${RESET}" \
        "${c_failed}" "${failed}" "${RESET}" \
        "${skipped}")"
    _emit "${console}" "${plain}"
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
