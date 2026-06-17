#!/usr/bin/env bats
# tests/entrypoint.bats — sandevistan.sh entry point behaviour.

load 'test_helper'

@test "sourcing sandevistan.sh does not start the main loop" {
    run timeout 10 bash -c 'source "'"${SANDEVISTAN_ROOT}"'/sandevistan.sh"; echo SOURCED_OK'
    [ "$status" -eq 0 ]
    [[ "$output" == *"SOURCED_OK"* ]]
}

@test "every module menu and core helper is registered after a full source" {
    run bash -c '
        export SANDEVISTAN_ROOT="'"${SANDEVISTAN_ROOT}"'"
        source "$SANDEVISTAN_ROOT/lib/core.sh"
        source "$SANDEVISTAN_ROOT/lib/ui.sh"
        source "$SANDEVISTAN_ROOT/lib/installer.sh"
        for m in "$SANDEVISTAN_ROOT"/lib/modules/*.sh; do source "$m"; done
        for fn in recon_menu vulnerability_menu exploitation_menu \
                  postexploitation_menu credential_menu payload_menu \
                  ensure_command ensure_repo prompt_yesno; do
            declare -F "$fn" >/dev/null || { echo "missing: $fn"; exit 1; }
        done
        echo ALL_REGISTERED'
    [ "$status" -eq 0 ]
    [[ "$output" == *"ALL_REGISTERED"* ]]
}

@test "handle_selection warns on an out-of-range choice" {
    run env TERM=xterm bash -c '
        source "'"${SANDEVISTAN_ROOT}"'/sandevistan.sh"
        handle_selection 999'
    [ "$status" -eq 0 ]
    [[ "$output" == *"Invalid selection"* ]]
}
