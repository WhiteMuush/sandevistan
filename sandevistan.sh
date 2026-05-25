#!/usr/bin/env bash
# sandevistan.sh — Cyberpunk cybersecurity toolkit launcher.
#
# This is a thin entry point. The actual implementation lives under lib/.
# See docs/ARCHITECTURE.md for the layout and docs/ADDING_A_TOOL.md to
# contribute new tools.

# Strict mode without -e: the interactive loop must survive commands that
# legitimately exit non-zero (failed scans, ^C inside subcommands, etc.).
set -uo pipefail

# Resolve the directory holding this script, even when launched via symlink.
SANDEVISTAN_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
readonly SANDEVISTAN_ROOT
export SANDEVISTAN_ROOT

# Source libraries in dependency order.
# shellcheck source=lib/core.sh
source "${SANDEVISTAN_ROOT}/lib/core.sh"
# shellcheck source=lib/ui.sh
source "${SANDEVISTAN_ROOT}/lib/ui.sh"
# shellcheck source=lib/installer.sh
source "${SANDEVISTAN_ROOT}/lib/installer.sh"

# Load all modules.
for module in "${SANDEVISTAN_ROOT}"/lib/modules/*.sh; do
    # shellcheck source=/dev/null
    source "$module"
done
unset module

# Dispatch the main menu selection.
handle_selection() {
    case "${1:-}" in
        1)
            log_step "Initializing NETWORK RECONNAISSANCE..."
            sleep 1
            recon_menu
            ;;
        2)
            log_step "Launching VULNERABILITY SCANNER..."
            sleep 1
            vulnerability_menu
            ;;
        3)
            log_step "Loading EXPLOITATION FRAMEWORK..."
            sleep 1
            exploitation_menu
            ;;
        4)
            log_step "Activating POST-EXPLOITATION modules..."
            sleep 1
            postexploitation_menu
            ;;
        5)
            log_step "Starting CREDENTIAL HARVESTER..."
            sleep 1
            credential_menu
            ;;
        6)
            log_step "Loading PAYLOAD GENERATOR..."
            sleep 1
            payload_menu
            ;;
        7)
            log_step "SYSTEM SHUTDOWN"
            log_info "Closing connection..."
            sleep 1
            clear
            exit 0
            ;;
        *)
            log_warn "Invalid selection"
            sleep 1
            clear
            ;;
    esac
}

main_loop() {
    clear
    while true; do
        display_ascii_info
        display_main_menu
        shell_prompt
        local choice
        read -r choice
        handle_selection "$choice"
    done
}

# Only run the loop when executed directly (not when sourced for tests).
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_loop
fi
