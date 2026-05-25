#!/usr/bin/env bash
# lib/modules/recon.sh — Network reconnaissance module.

if [[ -n "${SANDEVISTAN_MODULE_RECON_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_MODULE_RECON_LOADED=1

# --- individual tool runners ------------------------------------------------

recon_run_nmap() {
    ensure_command "nmap" "install_apt nmap" || return 0
    local target
    target=$(prompt_value "Enter target (IP/hostname)")
    [[ -z "$target" ]] && { log_warn "Target is required."; return 0; }
    log_step "Executing Nmap scan against ${target}"
    nmap "$target"
}

recon_run_masscan() {
    ensure_command "masscan" "install_apt masscan" || return 0
    local target ports
    target=$(prompt_value "Enter target (IP/range)")
    ports=$(prompt_value "Enter ports" "1-1000")
    log_step "Running Masscan on ${target} ports ${ports}"
    maybe_sudo masscan "$target" -p"$ports" --rate=1000
}

recon_run_recon_ng() {
    ensure_command "recon-ng" "install_apt recon-ng" || return 0
    log_step "Starting Recon-ng"
    recon-ng
}

recon_run_amass() {
    ensure_command "amass" "install_apt amass" || return 0
    local domain
    domain=$(prompt_value "Enter domain")
    [[ -z "$domain" ]] && { log_warn "Domain is required."; return 0; }
    log_step "Running Amass enumeration on ${domain}"
    amass enum -d "$domain"
}

recon_run_sublist3r() {
    ensure_command "sublist3r" "install_apt sublist3r" || return 0
    local domain
    domain=$(prompt_value "Enter domain")
    [[ -z "$domain" ]] && { log_warn "Domain is required."; return 0; }
    log_step "Running Sublist3r on ${domain}"
    sublist3r -d "$domain"
}

recon_run_theharvester() {
    ensure_command "theHarvester" "install_apt theharvester" || return 0
    local domain
    domain=$(prompt_value "Enter domain")
    [[ -z "$domain" ]] && { log_warn "Domain is required."; return 0; }
    log_step "Running theHarvester on ${domain}"
    theHarvester -d "$domain" -b all
}

recon_run_dirb() {
    ensure_command "dirb" "install_apt dirb" || return 0
    local url
    url=$(prompt_value "Enter URL")
    [[ -z "$url" ]] && { log_warn "URL is required."; return 0; }
    log_step "Running dirb against ${url}"
    dirb "$url"
}

recon_run_dnsenum() {
    ensure_command "dnsenum" "install_apt dnsenum" || return 0
    local domain
    domain=$(prompt_value "Enter domain")
    [[ -z "$domain" ]] && { log_warn "Domain is required."; return 0; }
    log_step "Running dnsenum on ${domain}"
    dnsenum "$domain"
}

recon_run_whatweb() {
    ensure_command "whatweb" "install_apt whatweb" || return 0
    local url
    url=$(prompt_value "Enter URL")
    [[ -z "$url" ]] && { log_warn "URL is required."; return 0; }
    log_step "Running WhatWeb on ${url}"
    whatweb "$url"
}

# --- menu -------------------------------------------------------------------

recon_menu() {
    clear
    display_ascii_info
    draw_banner "NETWORK RECONNAISSANCE MODULE"

    local options=(
        "1) Nmap"
        "2) Masscan"
        "3) Recon-ng"
        "4) Amass"
        "5) Sublist3r"
        "6) theHarvester"
        "7) dirb"
        "8) dnsenum"
        "9) WhatWeb"
        "99) Back to Main Menu"
    )
    render_options "${options[@]}"
    close_banner

    local sub_choice
    shell_prompt
    read -r sub_choice

    case "$sub_choice" in
        1)  recon_run_nmap ;;
        2)  recon_run_masscan ;;
        3)  recon_run_recon_ng ;;
        4)  recon_run_amass ;;
        5)  recon_run_sublist3r ;;
        6)  recon_run_theharvester ;;
        7)  recon_run_dirb ;;
        8)  recon_run_dnsenum ;;
        9)  recon_run_whatweb ;;
        99) log_step "Returning to Main Menu"; sleep 1; clear; return ;;
        *)  log_warn "Invalid selection"; sleep 1; clear; return ;;
    esac

    press_enter_to_continue
}
