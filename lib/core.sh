#!/usr/bin/env bash
# lib/core.sh — Core constants and color palette shared by all modules.
# Source-only file. Do not execute directly.

# Guard against double-sourcing.
if [[ -n "${SANDEVISTAN_CORE_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_CORE_LOADED=1

# Project metadata.
readonly SANDEVISTAN_VERSION="2.1.0"
readonly SANDEVISTAN_AUTHOR="Melvin PETIT (WhiteMuush)"
readonly SANDEVISTAN_REPO="https://github.com/WhiteMuush/sandevistan"

# Default location where third-party tools are cloned/installed.
# Override by exporting SANDEVISTAN_TOOLS_DIR before launching the script.
: "${SANDEVISTAN_TOOLS_DIR:=${HOME}/tools}"
export SANDEVISTAN_TOOLS_DIR

# Color palette. tput is preferred when a TTY is attached; otherwise colors
# degrade to empty strings so logs and pipes stay clean.
if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
    RESET="$(tput sgr0)"
    BOLD="$(tput bold)"
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    BLUE="$(tput setaf 6)"
    GRAY="$(tput setaf 8)"
    BRIGHT_RED="${BOLD}$(tput setaf 1)"
    BRIGHT_GREEN="${BOLD}$(tput setaf 2)"
    BRIGHT_BLUE="${BOLD}$(tput setaf 6)"
else
    RESET=""; BOLD=""; RED=""; GREEN=""; BLUE=""; GRAY=""
    BRIGHT_RED=""; BRIGHT_GREEN=""; BRIGHT_BLUE=""
fi
export RESET BOLD RED GREEN BLUE GRAY BRIGHT_RED BRIGHT_GREEN BRIGHT_BLUE

# Cached username for the prompt; computed once.
SANDEVISTAN_USER="$(whoami)"
readonly SANDEVISTAN_USER
export SANDEVISTAN_USER
