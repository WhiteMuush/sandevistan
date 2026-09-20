#!/usr/bin/env bats
# tests/recon.bats - lib/modules/recon.sh. Exercises the nmap privilege
# fallback only; the wrapped tools are stubbed and never executed for real.

load 'test_helper'

setup() {
    load_libs
    source "${SANDEVISTAN_ROOT}/lib/logger.sh"
    source "${SANDEVISTAN_ROOT}/lib/session.sh"
    source "${SANDEVISTAN_ROOT}/lib/modules/recon.sh"
    unset SANDEVISTAN_WORKSPACE SANDEVISTAN_LOG_FILE

    # Stubs: never touch the network, sudo, or the real scanners.
    ensure_command() { return 0; }
    prompt_value() { echo "10.0.0.1"; }
    maybe_sudo() { "$@"; }
    nmap() { echo "NMAP_ARGS: $*"; }
}

@test "recon_run_nmap: SYN scan (no --unprivileged) when raw sockets work" {
    has_raw_socket() { return 0; }
    run recon_run_nmap
    [ "$status" -eq 0 ]
    [[ "$output" == *"NMAP_ARGS: 10.0.0.1"* ]]
    [[ "$output" != *"--unprivileged"* ]]
}

@test "recon_run_nmap: falls back to --unprivileged when raw sockets fail" {
    has_raw_socket() { return 1; }
    run recon_run_nmap
    [ "$status" -eq 0 ]
    [[ "$output" == *"NMAP_ARGS: --unprivileged 10.0.0.1"* ]]
}

@test "recon_run_masscan: runs when raw sockets are available" {
    has_raw_socket() { return 0; }
    masscan() { echo "MASSCAN_RAN: $*"; }
    run recon_run_masscan
    [ "$status" -eq 0 ]
    [[ "$output" == *"MASSCAN_RAN:"* ]]
}

@test "recon_run_masscan: skips cleanly (no crash) when no raw socket" {
    has_raw_socket() { return 1; }
    masscan() { echo "MASSCAN_RAN: $*"; }
    run recon_run_masscan
    [ "$status" -eq 0 ]
    [[ "$output" != *"MASSCAN_RAN:"* ]]
    [[ "$output" == *"raw socket"* ]]
}
