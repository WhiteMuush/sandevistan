#!/usr/bin/env bats
# tests/core.bats — lib/core.sh: constants, colour palette, load guard.

load 'test_helper'

setup() {
    unset SANDEVISTAN_TOOLS_DIR
    load_libs
}

@test "core: load guard is set after sourcing" {
    [ "$SANDEVISTAN_CORE_LOADED" = "1" ]
}

@test "core: re-sourcing is a no-op and does not fail on readonly vars" {
    run source "${SANDEVISTAN_ROOT}/lib/core.sh"
    [ "$status" -eq 0 ]
}

@test "core: colours degrade to empty strings when stdout is not a TTY" {
    # bats captures stdout, so [[ -t 1 ]] is false inside the suite.
    [ -z "$RED" ]
    [ -z "$RESET" ]
    [ -z "$BRIGHT_RED" ]
}

@test "core: version metadata is exposed" {
    [ -n "$SANDEVISTAN_VERSION" ]
}

@test "core: tools dir defaults to ~/tools" {
    [ "$SANDEVISTAN_TOOLS_DIR" = "${HOME}/tools" ]
}

@test "core: SANDEVISTAN_TOOLS_DIR override is honoured" {
    run bash -c 'export SANDEVISTAN_TOOLS_DIR=/opt/custom-tools; source "'"${SANDEVISTAN_ROOT}"'/lib/core.sh"; printf %s "$SANDEVISTAN_TOOLS_DIR"'
    [ "$status" -eq 0 ]
    [ "$output" = "/opt/custom-tools" ]
}
