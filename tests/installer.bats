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

# --- screen_reset + install clear -------------------------------------------

@test "screen_reset: no-op (returns 0) when stdout is not a terminal" {
    run screen_reset
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "ensure_command: clears the screen after a successful install" {
    local bindir marker
    bindir="$(mktemp -d)"
    marker="${bindir}/cleared"
    PATH="${bindir}:${PATH}"

    # Override the terminal clear with an observable marker, and make the
    # install callback drop a working binary onto PATH.
    screen_reset() { : > "${marker}"; }
    _fake_install() {
        printf '#!/bin/sh\nexit 0\n' > "${bindir}/sandevistan_fake_tool"
        chmod +x "${bindir}/sandevistan_fake_tool"
    }

    run ensure_command sandevistan_fake_tool "_fake_install" <<< "yes"
    [ "$status" -eq 0 ]
    [ -f "${marker}" ]

    rm -rf "${bindir}"
}

# --- has_raw_socket ---------------------------------------------------------

@test "has_raw_socket: returns non-zero when no probe interpreter is present" {
    # Point PATH at an empty dir so neither python3 nor perl resolves; the
    # probe then has no way to open a socket and must report 'no raw'. Only
    # shell builtins run here, so an empty PATH is safe.
    local emptydir saved
    emptydir="$(mktemp -d)"
    saved="$PATH"
    PATH="$emptydir"
    run has_raw_socket
    PATH="$saved"
    rm -rf "$emptydir"
    [ "$status" -ne 0 ]
}

# --- require_raw_socket ------------------------------------------------------

@test "require_raw_socket: returns 0 when a raw socket is available" {
    has_raw_socket() { return 0; }
    run require_raw_socket "masscan"
    [ "$status" -eq 0 ]
}

@test "require_raw_socket: returns non-zero with guidance when raw is missing" {
    has_raw_socket() { return 1; }
    run require_raw_socket "masscan"
    [ "$status" -ne 0 ]
    [[ "$output" == *"raw socket"* ]]
}

@test "ensure_command: redraw of the header is terminal-gated (skipped when piped)" {
    local bindir marker
    bindir="$(mktemp -d)"
    marker="${bindir}/redrawn"
    PATH="${bindir}:${PATH}"
    screen_reset() { :; }
    display_ascii_info() { : > "${marker}"; }
    _fake_install() {
        printf '#!/bin/sh\nexit 0\n' > "${bindir}/sandevistan_fake_tool2"
        chmod +x "${bindir}/sandevistan_fake_tool2"
    }
    run ensure_command sandevistan_fake_tool2 "_fake_install" <<< "yes"
    [ "$status" -eq 0 ]
    [ ! -f "${marker}" ]
    rm -rf "${bindir}"
}
