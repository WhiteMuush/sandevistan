#!/usr/bin/env bash
# lib/modules/credentials.sh — Credential harvesting module.

if [[ -n "${SANDEVISTAN_MODULE_CREDS_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_MODULE_CREDS_LOADED=1

# ---------------------------------------------------------------------------
# Hashcat
# ---------------------------------------------------------------------------

credentials_run_hashcat() {
    ensure_command "hashcat" "install_apt hashcat" || return 0

    echo
    log_step "Hashcat operations"
    echo -e "${BRIGHT_BLUE}[1]${RESET} Crack MD5 (-m 0)"
    echo -e "${BRIGHT_BLUE}[2]${RESET} Crack NTLM (-m 1000)"
    echo -e "${BRIGHT_BLUE}[3]${RESET} Crack SHA256 (-m 1400)"
    echo -e "${BRIGHT_BLUE}[4]${RESET} Show example hashes"
    echo -e "${BRIGHT_BLUE}[5]${RESET} Custom attack"

    local choice hashfile wordlist mode
    read -rp "Select option: " choice
    case "$choice" in
        1)
            hashfile=$(prompt_value "Enter hash file path")
            wordlist=$(prompt_value "Enter wordlist path" "/usr/share/wordlists/rockyou.txt")
            log_step "Cracking MD5 hashes"
            hashcat -m 0 -a 0 "$hashfile" "$wordlist"
            ;;
        2)
            hashfile=$(prompt_value "Enter hash file path")
            wordlist=$(prompt_value "Enter wordlist path")
            log_step "Cracking NTLM hashes"
            hashcat -m 1000 -a 0 "$hashfile" "$wordlist"
            ;;
        3)
            hashfile=$(prompt_value "Enter hash file path")
            wordlist=$(prompt_value "Enter wordlist path")
            log_step "Cracking SHA256 hashes"
            hashcat -m 1400 -a 0 "$hashfile" "$wordlist"
            ;;
        4)
            log_step "Common hash modes (first 50 entries)"
            hashcat --example-hashes | head -n 50
            ;;
        5)
            mode=$(prompt_value "Enter hash mode (-m)")
            hashfile=$(prompt_value "Enter hash file")
            wordlist=$(prompt_value "Enter wordlist")
            log_step "Running custom attack"
            hashcat -m "$mode" -a 0 "$hashfile" "$wordlist"
            ;;
        *)  log_warn "Invalid selection" ;;
    esac
}

# ---------------------------------------------------------------------------
# John the Ripper
# ---------------------------------------------------------------------------

credentials_run_john() {
    ensure_command "john" "install_apt john" || return 0

    echo
    log_step "John the Ripper operations"
    echo -e "${BRIGHT_BLUE}[1]${RESET} Crack with default mode"
    echo -e "${BRIGHT_BLUE}[2]${RESET} Crack with wordlist"
    echo -e "${BRIGHT_BLUE}[3]${RESET} Show cracked passwords"
    echo -e "${BRIGHT_BLUE}[4]${RESET} Crack ZIP file"

    local choice hashfile wordlist zipfile
    read -rp "Select option: " choice
    case "$choice" in
        1)
            hashfile=$(prompt_value "Enter hash file path")
            log_step "Running John in default mode"
            john "$hashfile"
            ;;
        2)
            hashfile=$(prompt_value "Enter hash file path")
            wordlist=$(prompt_value "Enter wordlist path")
            log_step "Cracking with wordlist"
            john --wordlist="$wordlist" "$hashfile"
            ;;
        3)
            hashfile=$(prompt_value "Enter hash file path")
            log_step "Showing cracked passwords"
            john --show "$hashfile"
            ;;
        4)
            zipfile=$(prompt_value "Enter ZIP file path")
            log_step "Extracting hash from ZIP"
            zip2john "$zipfile" > zip_hash.txt
            log_step "Cracking ZIP password"
            john zip_hash.txt
            ;;
        *)  log_warn "Invalid selection" ;;
    esac
}

# ---------------------------------------------------------------------------
# Hydra
# ---------------------------------------------------------------------------

credentials_run_hydra() {
    ensure_command "hydra" "install_apt hydra" || return 0

    echo
    log_step "Hydra network brute-force"
    echo -e "${BRIGHT_BLUE}[1]${RESET} SSH"
    echo -e "${BRIGHT_BLUE}[2]${RESET} FTP"
    echo -e "${BRIGHT_BLUE}[3]${RESET} HTTP POST form"
    echo -e "${BRIGHT_BLUE}[4]${RESET} RDP"
    echo -e "${BRIGHT_BLUE}[5]${RESET} SMB"

    local choice target username passlist params
    read -rp "Select option: " choice
    case "$choice" in
        1)
            target=$(prompt_value "Enter target IP")
            username=$(prompt_value "Enter username (or path to list)")
            passlist=$(prompt_value "Enter password list")
            log_step "Brute-forcing SSH"
            hydra -l "$username" -P "$passlist" "$target" ssh
            ;;
        2)
            target=$(prompt_value "Enter target IP")
            username=$(prompt_value "Enter username")
            passlist=$(prompt_value "Enter password list")
            log_step "Brute-forcing FTP"
            hydra -l "$username" -P "$passlist" "$target" ftp
            ;;
        3)
            target=$(prompt_value "Enter target URL")
            username=$(prompt_value "Enter username")
            passlist=$(prompt_value "Enter password list")
            params=$(prompt_value "Enter POST parameters (e.g., /login:user=^USER^&pass=^PASS^:F=incorrect)")
            log_step "Brute-forcing HTTP POST"
            hydra -l "$username" -P "$passlist" "$target" http-post-form "$params"
            ;;
        4)
            target=$(prompt_value "Enter target IP")
            username=$(prompt_value "Enter username")
            passlist=$(prompt_value "Enter password list")
            log_step "Brute-forcing RDP"
            hydra -l "$username" -P "$passlist" rdp://"$target"
            ;;
        5)
            target=$(prompt_value "Enter target IP")
            username=$(prompt_value "Enter username")
            passlist=$(prompt_value "Enter password list")
            log_step "Brute-forcing SMB"
            hydra -l "$username" -P "$passlist" "$target" smb
            ;;
        *)  log_warn "Invalid selection" ;;
    esac
}

# ---------------------------------------------------------------------------
# CrackMapExec / NetExec
# ---------------------------------------------------------------------------

credentials_run_crackmapexec() {
    local cme_cmd
    if command -v crackmapexec >/dev/null 2>&1; then
        cme_cmd=crackmapexec
    elif command -v cme >/dev/null 2>&1; then
        cme_cmd=cme
    elif command -v nxc >/dev/null 2>&1; then
        cme_cmd=nxc
    else
        log_warn "CrackMapExec / NetExec is not installed."
        if prompt_yesno "Install via apt?"; then
            install_apt crackmapexec
        else
            return 0
        fi
        cme_cmd=$(command -v crackmapexec || command -v cme || true)
    fi

    [[ -z "$cme_cmd" ]] && { log_error "CME binary not found."; return 0; }

    echo
    log_step "${cme_cmd} operations"
    echo -e "${BRIGHT_BLUE}[1]${RESET} SMB authentication / password spray"
    echo -e "${BRIGHT_BLUE}[2]${RESET} SMB share enumeration"
    echo -e "${BRIGHT_BLUE}[3]${RESET} Dump SAM database"
    echo -e "${BRIGHT_BLUE}[4]${RESET} Pass-the-Hash"

    local choice target username password hash
    read -rp "Select option: " choice
    case "$choice" in
        1)
            target=$(prompt_value "Enter target IP/range")
            username=$(prompt_value "Enter username")
            read -rsp "Enter password: " password; echo
            log_step "Password spraying"
            "$cme_cmd" smb "$target" -u "$username" -p "$password"
            ;;
        2)
            target=$(prompt_value "Enter target IP")
            log_step "Enumerating SMB shares"
            "$cme_cmd" smb "$target" --shares
            ;;
        3)
            target=$(prompt_value "Enter target IP")
            username=$(prompt_value "Enter username")
            read -rsp "Enter password: " password; echo
            log_step "Dumping SAM"
            "$cme_cmd" smb "$target" -u "$username" -p "$password" --sam
            ;;
        4)
            target=$(prompt_value "Enter target IP")
            username=$(prompt_value "Enter username")
            hash=$(prompt_value "Enter NTLM hash")
            log_step "Pass-the-Hash"
            "$cme_cmd" smb "$target" -u "$username" -H "$hash"
            ;;
        *)  log_warn "Invalid selection" ;;
    esac
}

# ---------------------------------------------------------------------------
# Responder
# ---------------------------------------------------------------------------

credentials_run_responder() {
    local dest="${SANDEVISTAN_TOOLS_DIR}/Responder"
    ensure_repo \
        "https://github.com/lgandx/Responder.git" \
        "$dest" || return 0

    local interface
    interface=$(prompt_value "Enter network interface (e.g., eth0)")
    [[ -z "$interface" ]] && { log_warn "Interface is required."; return 0; }
    log_info "Press Ctrl+C to stop."
    log_step "Starting Responder"
    run_in_dir "$dest" maybe_sudo python3 Responder.py -I "$interface" -wrf
}

# ---------------------------------------------------------------------------
# CredMaster
# ---------------------------------------------------------------------------

credentials_run_credmaster() {
    local dest="${SANDEVISTAN_TOOLS_DIR}/CredMaster"
    ensure_repo \
        "https://github.com/knavesec/CredMaster.git" \
        "$dest" \
        "install_pip_requirements ${dest}" || return 0

    echo
    log_step "CredMaster operations"
    echo -e "${BRIGHT_BLUE}[1]${RESET} Office365 spray"
    echo -e "${BRIGHT_BLUE}[2]${RESET} OWA spray"
    echo -e "${BRIGHT_BLUE}[3]${RESET} List plugins"

    local choice userlist password url
    read -rp "Select option: " choice
    case "$choice" in
        1)
            userlist=$(prompt_value "Enter user list file")
            read -rsp "Enter password: " password; echo
            log_step "Spraying Office365"
            run_in_dir "$dest" python3 credmaster.py --plugin o365 -u "$userlist" -p "$password"
            ;;
        2)
            url=$(prompt_value "Enter OWA URL")
            userlist=$(prompt_value "Enter user list file")
            read -rsp "Enter password: " password; echo
            log_step "Spraying OWA"
            run_in_dir "$dest" python3 credmaster.py --plugin owa --url "$url" -u "$userlist" -p "$password"
            ;;
        3)
            log_step "Available plugins"
            run_in_dir "$dest" python3 credmaster.py --list-plugins
            ;;
        *)  log_warn "Invalid selection" ;;
    esac
}

# ---------------------------------------------------------------------------
# BruteSpray
# ---------------------------------------------------------------------------

credentials_run_brutespray() {
    local dest="${SANDEVISTAN_TOOLS_DIR}/brutespray"
    ensure_repo \
        "https://github.com/x90skysn3k/brutespray.git" \
        "$dest" \
        "install_pip_requirements ${dest}" || return 0

    local nmapfile
    nmapfile=$(prompt_value "Enter Nmap XML file path")
    [[ -z "$nmapfile" ]] && { log_warn "XML file is required."; return 0; }
    log_step "Running BruteSpray on services discovered in ${nmapfile}"
    run_in_dir "$dest" python3 brutespray.py --file "$nmapfile" --threads 5 --hosts 5
}

# --- menu -------------------------------------------------------------------

credential_menu() {
    clear
    display_ascii_info
    draw_banner "CREDENTIAL HARVESTING"

    local options=(
        "1) Hashcat"
        "2) John the Ripper"
        "3) Hydra"
        "4) CrackMapExec / NetExec"
        "5) Responder"
        "6) CredMaster"
        "7) BruteSpray"
        "99) Back to Main Menu"
    )
    render_options "${options[@]}"
    close_banner

    local sub_choice
    shell_prompt
    read -r sub_choice

    case "$sub_choice" in
        1)  credentials_run_hashcat ;;
        2)  credentials_run_john ;;
        3)  credentials_run_hydra ;;
        4)  credentials_run_crackmapexec ;;
        5)  credentials_run_responder ;;
        6)  credentials_run_credmaster ;;
        7)  credentials_run_brutespray ;;
        99) log_step "Returning to Main Menu"; sleep 1; clear; return ;;
        *)  log_warn "Invalid selection"; sleep 1; clear; return ;;
    esac

    press_enter_to_continue
}
