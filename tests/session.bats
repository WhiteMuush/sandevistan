#!/usr/bin/env bats
# tests/session.bats - lib/session.sh: engagement workspace, name safety and
# the run_logged wrapper. Sources logger.sh first, as production does.

load 'test_helper'

setup() {
    load_libs
    source "${SANDEVISTAN_ROOT}/lib/logger.sh"
    source "${SANDEVISTAN_ROOT}/lib/session.sh"
    WS_ROOT="$(mktemp -d)"
    export SANDEVISTAN_WORKSPACE_ROOT="${WS_ROOT}"
    unset SANDEVISTAN_WORKSPACE SANDEVISTAN_LOG_FILE
    _log_reset_stats
}

teardown() {
    rm -rf "${WS_ROOT}"
}

@test "slugify: lowercases and replaces non-alnum with hyphen" {
    run _slugify "Nmap scan: 10.0.0.1"
    [ "$status" -eq 0 ]
    [ "$output" = "nmap-scan-10-0-0-1" ]
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

@test "session_init: falls back to a safe name on a traversal attempt" {
    session_init "../escape"
    [[ "${SANDEVISTAN_WORKSPACE}" == "${WS_ROOT}/engagement-"* ]]
}

@test "session_init: resets the run counters" {
    SANDEVISTAN_STAT_OK=5
    session_init "reset-test"
    [ "${SANDEVISTAN_STAT_OK}" -eq 0 ]
}

@test "file log: session_init writes a colour-free, timestamped start line" {
    session_init "log-test"
    grep -q "session start: log-test" "${SANDEVISTAN_LOG_FILE}"
    grep -qE '^\[[0-9]{4}-[0-9]{2}-[0-9]{2}T' "${SANDEVISTAN_LOG_FILE}"
}

@test "session_output_file: path under output/ when active, empty otherwise" {
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
    _log_reset_stats
    run_logged "true task" true >/dev/null
    [ "${SANDEVISTAN_STAT_OK}" -eq 1 ]
}

@test "run_logged: failure records failed and preserves the exit code" {
    session_init "run-fail"
    run run_logged "false task" bash -c 'exit 3'
    [ "$status" -eq 3 ]
    _log_reset_stats
    run_logged "false task" bash -c 'exit 3' >/dev/null || true
    [ "${SANDEVISTAN_STAT_FAILED}" -eq 1 ]
}

@test "run_logged: captures command output into the workspace" {
    session_init "run-capture"
    run_logged "echo task" bash -c 'echo hello-capture' >/dev/null
    grep -rq "hello-capture" "${SANDEVISTAN_WORKSPACE}/output/"
}
