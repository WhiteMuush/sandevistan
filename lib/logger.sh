#!/usr/bin/env bash
# lib/logger.sh - Plain timestamped logging with a session-file mirror.
#
# Overrides the basic console loggers from installer.sh so every message reads
# "[<ISO-8601 UTC>] [LEVEL] message", and is mirrored colour-free to
# SANDEVISTAN_LOG_FILE when a session is open (set by lib/session.sh). No
# play/task/recap: a straight, greppable log.
#
# Source AFTER installer.sh. Source-only file; do not execute directly.

if [[ -n "${SANDEVISTAN_LOGGER_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_LOGGER_LOADED=1

_log_ts() { date -u +%Y-%m-%dT%H:%M:%SZ; }

# Append a colour-free "[ts] [LEVEL] msg" line to the session log, if open.
_log_to_file() {
    [[ -n "${SANDEVISTAN_LOG_FILE:-}" ]] || return 0
    printf '[%s] [%s] %s\n' "$(_log_ts)" "$1" "$2" >> "${SANDEVISTAN_LOG_FILE}"
}

# _log <level> <color> <fd> <message...>
_log() {
    local level="$1" color="$2" fd="$3"; shift 3
    printf '[%s] %s[%s]%s %s\n' "$(_log_ts)" "${color}" "${level}" "${RESET}" "$*" >&"${fd}"
    _log_to_file "${level}" "$*"
}

log_step()    { _log STEP  "${BRIGHT_BLUE}"  1 "$*"; }
log_info()    { _log INFO  "${BRIGHT_BLUE}"  1 "$*"; }
log_warn()    { _log WARN  "${BRIGHT_RED}"   2 "$*"; }
log_success() { _log OK    "${BRIGHT_GREEN}" 1 "$*"; }
log_error()   { _log ERROR "${BRIGHT_RED}"   2 "$*"; }
