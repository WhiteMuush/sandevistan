#!/usr/bin/env bats
# tests/ui.bats — lib/ui.sh: banner and menu rendering helpers.

load 'test_helper'

setup() {
    load_libs
}

@test "render_options: turns 'N) Label' into bracketed entries" {
    run render_options "1) Nmap" "99) Back to Main Menu"
    [ "$status" -eq 0 ]
    [[ "$output" == *"[1]"* ]]
    [[ "$output" == *"Nmap"* ]]
    [[ "$output" == *"[99]"* ]]
    [[ "$output" == *"Back to Main Menu"* ]]
}

@test "shell_prompt: includes the current user and nexus host" {
    run shell_prompt
    [[ "$output" == *"${SANDEVISTAN_USER}"* ]]
    [[ "$output" == *"@nexus"* ]]
}

@test "draw_banner: renders the title inside a box" {
    run draw_banner "TEST MODULE"
    [ "$status" -eq 0 ]
    [[ "$output" == *"TEST MODULE"* ]]
    [[ "$output" == *"═"* ]]
}

@test "display_main_menu: lists every root entry and numbers them" {
    run display_main_menu
    [ "$status" -eq 0 ]
    [[ "$output" == *"NETWORK RECONNAISSANCE"* ]]
    [[ "$output" == *"VULNERABILITY SCANNING"* ]]
    [[ "$output" == *"PAYLOAD GENERATOR"* ]]
    [[ "$output" == *"LEAVE"* ]]
    [[ "$output" == *"[7]"* ]]
}

@test "display_ascii_info: renders without error" {
    run display_ascii_info
    [ "$status" -eq 0 ]
    [[ "$output" == *"SANDEVISTAN"* ]]
}
