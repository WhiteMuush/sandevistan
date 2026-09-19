#!/usr/bin/env bash
# lib/logger.sh - Ansible-style run logging: PLAY/TASK headers, ok/changed/
# failed/skipped states and a PLAY RECAP. Output goes to stdout and, when
# SANDEVISTAN_LOG_FILE is set (by lib/session.sh), is mirrored colour-free to
# that file. This module owns formatting and the run counters only; it has no
# filesystem responsibility of its own.
#
# Source-only file. Do not execute directly.

if [[ -n "${SANDEVISTAN_LOGGER_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_LOGGER_LOADED=1

# Width used to pad TASK/PLAY header lines with trailing stars, like Ansible.
readonly _LOG_LINE_WIDTH=79

# --- statistics -------------------------------------------------------------

_log_reset_stats() {
    SANDEVISTAN_STAT_TASKS=0
    SANDEVISTAN_STAT_OK=0
    SANDEVISTAN_STAT_CHANGED=0
    SANDEVISTAN_STAT_FAILED=0
    SANDEVISTAN_STAT_SKIPPED=0
    SANDEVISTAN_STAT_UNREACHABLE=0
}

# --- helpers ----------------------------------------------------------------

# Remove ANSI colour/escape sequences from a string.
_strip_ansi() {
    printf '%s' "$1" | sed -E 's/\x1b\[[0-9;]*m//g'
}

# Pad a header prefix with trailing stars up to the fixed line width.
_pad_stars() {
    local prefix="$1"
    local len=$(( _LOG_LINE_WIDTH - ${#prefix} - 1 ))
    (( len < 3 )) && len=3
    local stars
    printf -v stars '%*s' "${len}" ''
    printf '%s' "${stars// /*}"
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
    local c_changed="" c_failed="" c_unreach=""
    (( changed > 0 ))     && c_changed="${YELLOW}"
    (( failed > 0 ))      && c_failed="${BRIGHT_RED}"
    (( unreachable > 0 )) && c_unreach="${BRIGHT_RED}"

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
