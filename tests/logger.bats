#!/usr/bin/env bats
# tests/logger.bats - lib/logger.sh: Ansible-style states, counters, recap and
# the colour-free file mirror. No workspace/filesystem concern here.

load 'test_helper'

setup() {
    load_libs
    source "${SANDEVISTAN_ROOT}/lib/logger.sh"
    unset SANDEVISTAN_LOG_FILE
    _log_reset_stats
}

@test "strip_ansi: removes color escape sequences" {
    local colored plain
    colored="$(printf '\033[32mok\033[0m')"
    plain="$(_strip_ansi "${colored}")"
    [ "${plain}" = "ok" ]
}

@test "log_ok increments the ok counter" {
    log_ok "did a thing" >/dev/null
    [ "${SANDEVISTAN_STAT_OK}" -eq 1 ]
}

@test "log_failed increments the failed counter" {
    log_failed "broke" >/dev/null
    [ "${SANDEVISTAN_STAT_FAILED}" -eq 1 ]
}

@test "log_changed and log_skipped increment their counters" {
    log_changed "installed" >/dev/null
    log_skipped "already there" >/dev/null
    [ "${SANDEVISTAN_STAT_CHANGED}" -eq 1 ]
    [ "${SANDEVISTAN_STAT_SKIPPED}" -eq 1 ]
}

@test "recap: reports the accumulated counts in Ansible format" {
    log_ok "a" >/dev/null
    log_ok "b" >/dev/null
    log_failed "c" >/dev/null
    run log_recap
    [ "$status" -eq 0 ]
    [[ "$output" == *"ok=2"* ]]
    [[ "$output" == *"failed=1"* ]]
    [[ "$output" == *"changed=0"* ]]
    [[ "$output" == *"PLAY RECAP"* ]]
}

@test "file mirror: state lines are written without ANSI and with a timestamp" {
    local logfile
    logfile="$(mktemp)"
    export SANDEVISTAN_LOG_FILE="${logfile}"
    log_ok "plain message" >/dev/null
    grep -q "ok: plain message" "${logfile}"
    ! grep -q $'\033' "${logfile}"
    grep -qE '^\[[0-9]{4}-[0-9]{2}-[0-9]{2}T' "${logfile}"
    rm -f "${logfile}"
}
