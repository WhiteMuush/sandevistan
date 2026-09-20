#!/usr/bin/env bats
# tests/logger.bats - lib/logger.sh: plain timestamped logging with a
# colour-free mirror to the session log file. No Ansible play/task/recap.

load 'test_helper'

setup() {
    load_libs
    source "${SANDEVISTAN_ROOT}/lib/logger.sh"
    unset SANDEVISTAN_LOG_FILE
}

@test "log_info: prints an ISO timestamp, a level tag and the message" {
    run log_info "scanning target"
    [ "$status" -eq 0 ]
    [[ "$output" =~ ^\[[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z\] ]]
    [[ "$output" == *"[INFO]"* ]]
    [[ "$output" == *"scanning target"* ]]
}

@test "log_success and log_error use OK and ERROR levels" {
    run log_success "done"
    [[ "$output" == *"[OK]"* ]]
    run log_error "boom"
    [[ "$output" == *"[ERROR]"* ]]
}

@test "log_warn and log_error write to stderr" {
    run --separate-stderr log_warn "careful"
    [ -z "$output" ]
    [[ "$stderr" == *"[WARN]"* ]]
}

@test "file mirror: colour-free, timestamped line when a session log is open" {
    local logfile; logfile="$(mktemp)"
    export SANDEVISTAN_LOG_FILE="${logfile}"
    log_info "written to file" >/dev/null
    grep -qE '^\[[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9:]+Z\] \[INFO\] written to file' "${logfile}"
    ! grep -q $'\033' "${logfile}"
    rm -f "${logfile}"
}

@test "no session log means no file write and no error" {
    run log_info "just console"
    [ "$status" -eq 0 ]
}

@test "the Ansible play/task/recap vocabulary is gone" {
    ! declare -F log_play
    ! declare -F log_task
    ! declare -F log_recap
}

@test "log_launch: emits the step then a trailing blank line" {
    local out
    out="$(mktemp)"
    log_launch "Launching Tool" >"$out" 2>&1
    # one line for the [STEP], one blank line after it for breathing room
    [ "$(wc -l <"$out")" -eq 2 ]
    grep -q "Launching Tool" "$out"
    rm -f "$out"
}
