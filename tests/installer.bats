#!/usr/bin/env bats
# tests/installer.bats — lib/installer.sh: prompts, privilege wrapper,
# and the ensure_command gate. None of these touch the wrapped tools.

load 'test_helper'

setup() {
    load_libs
}

# --- prompt_yesno -----------------------------------------------------------

@test "prompt_yesno: accepts y / yes / Y / YES" {
    run prompt_yesno "Q?" <<< "yes"; [ "$status" -eq 0 ]
    run prompt_yesno "Q?" <<< "y";   [ "$status" -eq 0 ]
    run prompt_yesno "Q?" <<< "Y";   [ "$status" -eq 0 ]
    run prompt_yesno "Q?" <<< "YES"; [ "$status" -eq 0 ]
}

@test "prompt_yesno: rejects no / empty / garbage" {
    run prompt_yesno "Q?" <<< "no";    [ "$status" -ne 0 ]
    run prompt_yesno "Q?" <<< "";      [ "$status" -ne 0 ]
    run prompt_yesno "Q?" <<< "maybe"; [ "$status" -ne 0 ]
}

# --- prompt_value -----------------------------------------------------------
# The prompt itself goes to stderr (via read -rp); discard it so only the
# echoed result is captured.

@test "prompt_value: returns the default on empty input" {
    result="$(prompt_value 'Q' 'deflt' <<< '' 2>/dev/null)"
    [ "$result" = "deflt" ]
}

@test "prompt_value: returns user input over the default" {
    result="$(prompt_value 'Q' 'deflt' <<< 'custom' 2>/dev/null)"
    [ "$result" = "custom" ]
}

@test "prompt_value: works with no default" {
    result="$(prompt_value 'Q' <<< 'val' 2>/dev/null)"
    [ "$result" = "val" ]
}

# --- maybe_sudo -------------------------------------------------------------

@test "maybe_sudo: runs the command directly when effective UID is 0" {
    # Override id so the root branch is taken deterministically, without
    # ever invoking real sudo.
    id() { echo 0; }
    run maybe_sudo echo direct
    [ "$status" -eq 0 ]
    [ "$output" = "direct" ]
}

# --- ensure_command ---------------------------------------------------------

@test "ensure_command: returns 0 for a present command without prompting" {
    # 'bash' always exists; the install callback (false) must never run.
    run ensure_command bash "false"
    [ "$status" -eq 0 ]
}

@test "ensure_command: returns 1 when the command is absent and the user declines" {
    run ensure_command sandevistan_definitely_missing_bin "false" <<< "no"
    [ "$status" -eq 1 ]
}
