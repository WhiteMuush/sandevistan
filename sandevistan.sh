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
# shellcheck source=lib/compat.sh
source "${SANDEVISTAN_ROOT}/lib/compat.sh"
# shellcheck source=lib/logger.sh
source "${SANDEVISTAN_ROOT}/lib/logger.sh"
# shellcheck source=lib/session.sh
source "${SANDEVISTAN_ROOT}/lib/session.sh"

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
            log_play "Network reconnaissance"
            sleep 1
            recon_menu
            ;;
        2)
            log_play "Vulnerability scanning"
            sleep 1
            vulnerability_menu
            ;;
        3)
            log_play "Exploitation"
            sleep 1
            exploitation_menu
            ;;
        4)
            log_play "Post-exploitation"
            sleep 1
            postexploitation_menu
            ;;
        5)
            log_play "Credential harvesting"
            sleep 1
            credential_menu
            ;;
        6)
            log_play "Payload generation"
            sleep 1
            payload_menu
            ;;
        7)
            log_step "SYSTEM SHUTDOWN"
            log_info "Closing connection..."
            log_recap
            log_info "Engagement saved to: $(session_dir)"
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
    session_init "engagement"
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
    # On a non-Debian host, offer to run inside the shared Debian box. This may
    # replace the current process with the containerised run and never return.
    compat_gate "${SANDEVISTAN_ROOT}" sandevistan.sh SANDEVISTAN
    main_loop
fi
