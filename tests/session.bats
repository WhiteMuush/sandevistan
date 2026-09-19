#!/usr/bin/env bats
# tests/session.bats - lib/session.sh: engagement workspace and Ansible-style
# logging (task/play headers, ok/changed/failed states, recap, file log).

load 'test_helper'

setup() {
    load_libs
    source "${SANDEVISTAN_ROOT}/lib/session.sh"
    WS_ROOT="$(mktemp -d)"
    export SANDEVISTAN_WORKSPACE_ROOT="${WS_ROOT}"
    unset SANDEVISTAN_WORKSPACE SANDEVISTAN_LOG_FILE
    _session_reset_stats
}

teardown() {
    rm -rf "${WS_ROOT}"
}

@test "slugify: lowercases and replaces non-alnum with hyphen" {
    run _slugify "Nmap scan: 10.0.0.1"
    [ "$status" -eq 0 ]
    [ "$output" = "nmap-scan-10-0-0-1" ]
}

@test "strip_ansi: removes color escape sequences" {
    local colored plain
    colored="$(printf '\033[32mok\033[0m')"
    plain="$(_strip_ansi "${colored}")"
    [ "${plain}" = "ok" ]
}

@test "validate_session_name: accepts a plain name, rejects traversal" {
    run _validate_session_name "client-audit"
    [ "$status" -eq 0 ]
    run _validate_session_name ".."
    [ "$status" -ne 0 ]
    run _validate_session_name "a/b"
    [ "$status" -ne 0 ]
    run _validate_session_name ""
    [ "$status" -ne 0 ]
}

@test "session_init: creates the workspace tree and a log file" {
    session_init "client-audit"
    [ -d "${SANDEVISTAN_WORKSPACE}" ]
    [ -d "${SANDEVISTAN_WORKSPACE}/loot" ]
    [ -d "${SANDEVISTAN_WORKSPACE}/output" ]
    [ -d "${SANDEVISTAN_WORKSPACE}/logs" ]
    [ -f "${SANDEVISTAN_LOG_FILE}" ]
    [[ "${SANDEVISTAN_WORKSPACE}" == "${WS_ROOT}/client-audit-"* ]]
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

@test "file log: state lines are written without ANSI and with a timestamp" {
    session_init "log-test"
    log_ok "plain message" >/dev/null
    grep -q "ok: plain message" "${SANDEVISTAN_LOG_FILE}"
    # No raw escape byte in the file.
    ! grep -q $'\033' "${SANDEVISTAN_LOG_FILE}"
    # ISO-8601 timestamp prefix.
    grep -qE '^\[[0-9]{4}-[0-9]{2}-[0-9]{2}T' "${SANDEVISTAN_LOG_FILE}"
}

@test "session_output_file: path under output/ when a session is active, empty otherwise" {
    run session_output_file "Nmap scan"
    [ -z "$output" ]
    session_init "out-test"
    run session_output_file "Nmap scan"
    [[ "$output" == "${SANDEVISTAN_WORKSPACE}/output/nmap-scan"* ]]
}

@test "run_logged: success records ok and returns 0" {
    session_init "run-ok"
    run run_logged "true task" true
    [ "$status" -eq 0 ]
    _session_reset_stats
    run_logged "true task" true >/dev/null
    [ "${SANDEVISTAN_STAT_OK}" -eq 1 ]
}

@test "run_logged: failure records failed and preserves the exit code" {
    session_init "run-fail"
    run run_logged "false task" bash -c 'exit 3'
    [ "$status" -eq 3 ]
    _session_reset_stats
    run_logged "false task" bash -c 'exit 3' >/dev/null || true
    [ "${SANDEVISTAN_STAT_FAILED}" -eq 1 ]
}

@test "run_logged: captures command output into the workspace" {
    session_init "run-capture"
    run_logged "echo task" bash -c 'echo hello-capture' >/dev/null
    grep -rq "hello-capture" "${SANDEVISTAN_WORKSPACE}/output/"
}
