#!/usr/bin/env bats
# tests/compat.bats - lib/compat.sh: host distro detection and the per-toolkit
# container bootstrap argument builders. No container is ever launched here.

load 'test_helper'

setup() {
    load_libs
    source "${SANDEVISTAN_ROOT}/lib/compat.sh"
    OSR_DIR="$(mktemp -d)"
}

teardown() {
    rm -rf "${OSR_DIR}"
}

_fake_osr() { printf '%s\n' "$2" > "${OSR_DIR}/$1"; printf '%s' "${OSR_DIR}/$1"; }

@test "distro family: plain Debian is debian" {
    local f; f="$(_fake_osr debian 'ID=debian')"
    [ "$(detect_distro_family "$f")" = "debian" ]
}

@test "distro family: derivatives via ID_LIKE are debian" {
    local f; f="$(_fake_osr kali 'ID=kali
ID_LIKE=debian')"
    [ "$(detect_distro_family "$f")" = "debian" ]
    f="$(_fake_osr ubuntu 'ID=ubuntu
ID_LIKE=debian')"
    [ "$(detect_distro_family "$f")" = "debian" ]
}

@test "distro family: Fedora/Bazzite is other" {
    local f; f="$(_fake_osr bazzite 'ID=bazzite
ID_LIKE="fedora"')"
    [ "$(detect_distro_family "$f")" = "other" ]
}

@test "distro family: Arch is other" {
    local f; f="$(_fake_osr arch 'ID=arch')"
    [ "$(detect_distro_family "$f")" = "other" ]
}

@test "host_is_supported: true on debian family, false otherwise" {
    local deb arch
    deb="$(_fake_osr d 'ID=debian')"
    arch="$(_fake_osr a 'ID=arch')"
    run host_is_supported "$deb";  [ "$status" -eq 0 ]
    run host_is_supported "$arch"; [ "$status" -ne 0 ]
}

@test "container_runtime: returns a known token" {
    run container_runtime
    [[ "$output" =~ ^(podman|docker|none)$ ]]
}

@test "box create args: named, host network, caps, single toolkit mount, sleep" {
    run _box_create_args pentest-sandevistan debian:stable-slim /host/sandevistan /host/engagements
    [[ "$output" == *"--name pentest-sandevistan"* ]]
    [[ "$output" == *"--network host"* ]]
    [[ "$output" == *"--cap-add NET_RAW"* ]]
    [[ "$output" == *"--cap-add NET_ADMIN"* ]]
    [[ "$output" == *"/host/sandevistan:/opt/toolkit"* ]]
    [[ "$output" != *"/opt/toolkits"* ]]
    [[ "$output" == *"/host/engagements:/root/pentest-engagements"* ]]
    [[ "$output" == *"debian:stable-slim"* ]]
    [[ "$output" == *"sleep infinity"* ]]
}

@test "box_name: one box per toolkit by default" {
    unset PENTEST_BOX_NAME
    [ "$(_box_name SANDEVISTAN)" = "pentest-sandevistan" ]
    [ "$(_box_name Ghostline)" = "pentest-ghostline" ]
}

@test "box_name: an explicit PENTEST_BOX_NAME wins over everything" {
    export PENTEST_BOX_NAME=custom-box
    [ "$(_box_name SANDEVISTAN)" = "custom-box" ]
}

@test "box exec args: interactive, marker env, engagements, inner script" {
    run _box_exec_args pentest-sandevistan /opt/toolkit/sandevistan.sh
    [[ "$output" == *"exec"* ]]
    [[ "$output" == *"-it"* ]]
    [[ "$output" == *"PENTEST_IN_BOX=1"* ]]
    [[ "$output" == *"PENTEST_ENGAGEMENTS=/root/pentest-engagements"* ]]
    [[ "$output" == *"pentest-sandevistan"* ]]
    [[ "$output" == *"/opt/toolkit/sandevistan.sh"* ]]
}

@test "enter_box uses the given entry script for the inner path" {
    run _box_exec_args pentest-sandevistan /opt/toolkit/ghostline.sh
    [[ "$output" == *"/opt/toolkit/ghostline.sh"* ]]
}
