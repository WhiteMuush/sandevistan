#!/bin/bash

#COLOR PANEL
RESET="$(tput sgr0)"
BOLD="$(tput bold)"
RED="$(tput setaf 1)"
BLUE="$(tput setaf 6)"
GRAY="$(tput setaf 8)"
BRIGHT_RED="${BOLD}$(tput setaf 1)"
BRIGHT_BLUE="${BOLD}$(tput setaf 6)"

# Initial clear
clear

# ASCII Art
read -r -d '' ASCII_ART << 'EOF'
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠶⠚⣡⠇⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⢀⡴⠋⢠⣾⠶⠋⠀⠀⣾⡆⠀⠀⠀⣸⢻⡄⠀⠀
⠀⠀⢠⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡴⣻⠀⠀⠀⠀⢠⣯⠁⣰⢿⣷⠀⠀⠀⣰⠋⣭⠀⣠⠞⢁⡼⠁⠀⠀
⠀⠀⢀⡯⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣹⣿⠃⠀⢠⢾⠟⣸⡏⣠⡿⠏⣾⢀⣀⣾⣇⣼⠃⠀⣿⡿⠋⠀⠀⠀⠀
⠀⠀⢸⠇⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⢻⡛⢠⡄⣻⠛⣇⡿⠀⢼⡇⣴⠷⠋⡏⠿⣏⣀⣦⠀⠛⠁⠀⠀⠀⠀⣀
⠀⠀⠈⢳⣻⡀⠀⠀⠀⠀⢠⣦⡀⠀⠀⡿⣬⡇⣸⡙⠁⠐⠉⠀⢰⣿⡼⣯⡆⣰⢧⡞⣿⡽⣽⣦⠀⠀⠀⠀⢀⠼⣹             
⠀⠀⠀⠀⠙⠣⣦⡀⠀⠀⠈⠳⣽⡄⣶⣹⢺⣿⢧⠀⠀⠀⠀⣀⣸⣸⣹⢿⡿⣱⠟⠈⣿⣿⡿⢹⡀⣠⢿⠂⣟⡿⠁
⠀⠀⠀⣀⡀⢠⡿⣍⠳⣄⠀⠀⣠⣀⣽⣇⠘⣽⡈⢠⡇⠎⣝⠙⣋⣹⠦⡾⠋⠀⠀⣠⢯⡏⠀⣸⢰⣿⢸⡄⠙⠁⠀
⣿⣄⠀⠙⢿⣾⣽⣼⣇⠈⡇⠀⣟⣿⢸⡷⠆⢈⠀⢈⣠⣿⣿⣾⠿⣿⡇⢁⢀⡆⡆⣏⡾⣥⣶⣻⠀⣿⢸⡇⠀⠀⠀
⠘⢾⣳⡀⢻⡎⠉⣼⣿⣆⣇⣠⣻⡉⠘⣷⠸⣧⣷⣹⠋⢹⠟⠀⣼⠯⠀⣼⢟⠇⢃⣿⢻⣿⡟⢿⢠⡯⣼⠃⠀⠀⠀
⠀⠀⠻⠃⣬⣗⠶⡿⠹⡟⣷⠀⠹⣇⡀⢪⢃⢽⠇⠁⠈⣠⣶⣼⣷⠋⠘⠿⠂⣤⣗⣿⠘⣧⡃⢨⠿⠞⠁⠀⠀⠀⠀
⠀⠀⠀⠀⢸⢿⣾⣔⡋⢙⡲⣶⣾⣟⣧⣾⡌⠻⢇⢠⢰⣷⠀⣿⡆⠀⠄⣴⣿⣿⣷⢻⣰⣯⣷⣯⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢶⣦⣏⠿⢿⡳⢭⣿⣶⣿⣯⣿⣿⢁⣴⡃⣼⢸⣞⢧⡀⠁⠅⣰⣾⣿⣿⣿⣿⠟⣿⣼⣷⡇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠈⣿⠇⠠⣼⣯⡶⣿⣻⣿⣿⢻⢺⣿⡳⠞⠃⠀⠙⠷⣿⣤⣴⣿⣿⣿⣿⣿⠇⣼⣼⣿⢹⠇⠀⠀⠀⠀⠀⠀⠀
⠀⣀⡀⠻⣄⢴⣷⢍⣙⣻⠮⠽⠿⠿⢍⡻⣷⣶⣅⡀⢶⣎⠻⣿⡿⣿⣿⣿⣟⣡⡿⣫⡇⣿⣟⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠙⢿⣇⣉⠻⡷⣷⠮⣝⣳⣔⡶⢖⢞⡱⣿⣟⣿⠃⢔⠙⢷⣮⡙⢷⣦⣆⣑⣤⣶⣯⣾⢟⢮⡳⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠈⠻⣽⠀⠘⠿⠀⠀⠀⢠⠶⠞⣈⡇⠀⣿⣡⡄⢬⣶⢶⢙⡷⣄⣉⠉⠛⢙⠟⢟⣅⠑⣕⡽⣎⢦⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠙⠀⠀⣠⠀⠀⠰⣡⡦⣄⣏⣃⡘⣿⣏⡄⣺⢷⣫⡾⣏⣽⣽⡻⣆⣸⠣⡀⢙⣿⣥⣙⠜⣸⠃⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠛⠀⠀⣠⠟⠀⢘⣏⣹⣟⣟⢾⡝⠏⢝⣩⠿⡏⠀⠈⢷⣻⣏⠀⠈⠛⠦⣉⣉⣠⠇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣀⣀⠤⠒⠋⠀⠀⣠⢾⠧⣀⡀⢀⣀⣉⣉⠉⠁⢰⢿⠢⡀⠀⠙⠿⢄⣀⡀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠘⠛⠒⠒⠒⠒⠺⣏⢳⣸⣤⣽⠟⣉⣁⣨⣛⡙⠿⣯⣸⣧⠟⠳⣤⢤⢀⣈⣩⠽⠃⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⣄⣠⠾⣿⠛⢟⠞⠙⠻⣗⡮⣬⣔⣲⡶⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⢾⡁⠀⠀⢨⠀⢀⢘⣯⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠲⠒⠻⠳⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀


EOF

info_list=(
    "HOST : Relic"
    ""
    "*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━......."
    ""
    "OS: Militech APOGEE SANDEVISTAN"
    "Architecture: cw_system_sandevistanedgerunner x64"
    "Creator: ${BRIGHT_BLUE}\e]8;;https://github.com/WhiteMuush\aMelvin PETIT\e]8;;\a${RESET}"
    ""
    "*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━......."
    ""
    "${BRIGHT_RED}Information System${RESET}:"
    ""
    "Welcome cyberpsycho,"
    "${BRIGHT_RED}SANDEVISTAN${RESET} ${BRIGHT_BLUE}is your ultimate hub a single space where every reconnaissance, exploitation,"
    "and post-exploitation tool converges. No more jumping between countless platforms,"
    "everything you need is right here, optimized and ready to deploy."
    "Unleash your potential, accelerate your actions, and dive deeper into systems with surgical precision."
)


display_ascii_info() {
    # Convert to arrays
    local -a info_lines ascii_lines
    info_lines=("${info_list[@]}")
    local IFS=$'\n'
    read -d '' -r -a ascii_lines <<< "$ASCII_ART"

    # Lengths
    local ascii_count=${#ascii_lines[@]}
    local info_count=${#info_lines[@]}

    # Center info vertically vs ASCII
    local vertical_offset=$(((ascii_count - info_count) / 2))

    # Max ASCII width (for padding)
    local max_width=0
    local line
    for line in "${ascii_lines[@]}"; do
        ((${#line} > max_width)) && max_width=${#line}
    done

    local spacing="  "

    # Render
    local i ascii_line colored_ascii colored_info info_idx info_line pad label value
    for ((i=0; i<ascii_count; i++)); do
        ascii_line="${ascii_lines[i]:-}"
        colored_ascii="${BRIGHT_RED}${ascii_line}${RESET}"

        colored_info=""
        if ((i >= vertical_offset && i < vertical_offset + info_count)); then
            info_idx=$((i - vertical_offset))
            info_line="${info_lines[$info_idx]:-}"

            # Colorize: label in bright red and value in bright blue
            if [[ "$info_line" == *:* ]]; then
                label="${info_line%%:*}"
                value="${info_line#*:}"
                value="${value# }"
                colored_info="${BRIGHT_RED}${label}${RESET}: ${BRIGHT_BLUE}${value}${RESET}"
            else
                colored_info="${BRIGHT_BLUE}${info_line}${RESET}"
            fi
        fi

        pad=$((max_width - ${#ascii_line}))
        ((pad < 0)) && pad=0

        printf "%b%b\n" \
            "   $colored_ascii" \
            "$(printf '%*s' "$pad" '')${spacing}${colored_info}"
    done
}

declare -a MENU_ITEMS=(
    "NETWORK RECONNAISSANCE"
    "VULNERABILITY SCANNING"
    "EXPLOITATION FRAMEWORK"
    "POST-EXPLOITATION"
    "CREDENTIAL HARVESTING"
    "PAYLOAD GENERATOR"
    "LEAVE"
)

display_menu() {

    echo -e "${BRIGHT_RED}"
    echo ""
    echo ""
    echo "      ╔══════════════════════════════════════════════╗"
    echo "      ║${RESET}     ${BRIGHT_BLUE}▓▒░    SANDEVISTAN Toolkit    ░▒▓${BRIGHT_RED}        ║"
    echo "      ╚══════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -e "       System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
    echo ""
    
    echo -e "        ${BRIGHT_BLUE}┌─                                      ─┐${RESET}"
    echo ""
    
    for i in "${!MENU_ITEMS[@]}"; do  
        item="${MENU_ITEMS[$i]}"
        num=$((i + 1))
        
        printf "            ${RED}[%d]${RESET} %s\n" "$num" "  ${BRIGHT_BLUE}$item"
    done
    echo ""
    echo -e "        ${BRIGHT_BLUE}└──                                    ──┘${RESET}"
    echo ""
}


check_and_install_tool() {
    local tool_name=$1
    local install_command=$2
    
    if ! command -v "$tool_name" &> /dev/null; then
        echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}$tool_name is not installed.${RESET}"
        read -rp "Would you like to install it? (yes/no): " install_choice
        
        case $install_choice in
            yes|y|Y|YES)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing $tool_name...\n"
                eval "$install_command"
                
                if command -v "$tool_name" &> /dev/null; then
                    echo -e "\n${BRIGHT_GREEN}[✓]${RESET} $tool_name installed successfully!\n"
                    return 0
                else
                    echo -e "\n${BRIGHT_RED}[✗]${RESET} Installation failed. Please install manually.\n"
                    return 1
                fi
                ;;
            *)
                echo -e "\n${BRIGHT_RED}[!]${RESET} Installation cancelled.\n"
                return 1
                ;;
        esac
    fi
    return 0
}


# Choice 1: Network Reconnaissance
network_reconnaissance_menu(){
    clear
    display_ascii_info
    echo -e "${BRIGHT_RED}"
    echo ""
    echo ""
    echo "      ╔══════════════════════════════════════════════╗"
    echo "      ║${RESET}   ${BRIGHT_BLUE}▓▒░  NETWORK RECONNAISSANCE MODULE  ░▒▓${BRIGHT_RED}    ║"
    echo "      ╚══════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -e "       System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
    echo ""
    
    echo -e "        ${BRIGHT_BLUE}┌─                                      ─┐${RESET}"
    echo ""


    local options=(
        "1) Nmap"
        "2) Masscan"
        "3) Recon-ng"
        "4) Amass"
        "5) Sublister"
        "7) TheHarvester"
        "8) Dirbuster"
        "9) dnsenum"
        "10) WhatWeb"
        "99) Back to Main Menu"
    )
    
    for option in "${options[@]}"; do
        echo -e "            ${RED}[${option%%)*}]${RESET} ${BRIGHT_BLUE}${option#*)}${RESET}"
    done
    
    echo ""
    echo -e "        ${BRIGHT_BLUE}└──                                    ──┘${RESET}"
    echo ""
    
    while true; do
        read -rp " ${BRIGHT_BLUE}user@nexus:~${RESET}${BRIGHT_RED}\$${RESET} " sub_choice
        
        case $sub_choice in
            1)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Nmap...\n"
                if check_and_install_tool "nmap" "sudo apt-get install -y nmap"; then
                    read -rp "Enter target (IP/hostname): " target
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Executing Nmap scan...\n"
                    nmap "$target"
                fi
                ;;
            2)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Masscan...\n"
                if check_and_install_tool "masscan" "sudo apt-get install -y masscan"; then
                    read -rp "Enter target (IP/range): " target
                    read -rp "Enter ports (e.g., 1-1000): " ports
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Performing Masscan...\n"
                    sudo masscan "$target" -p"$ports" --rate=1000
                fi
                ;;
            3)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Recon-ng...\n"
                if check_and_install_tool "recon-ng" "sudo apt-get install -y recon-ng"; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Starting Recon-ng...\n"
                    recon-ng
                fi
                ;;
            4)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Amass...\n"
                if check_and_install_tool "amass" "sudo apt-get install -y amass"; then
                    read -rp "Enter domain: " domain
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running Amass enumeration...\n"
                    amass enum -d "$domain"
                fi
                ;;
            5)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Sublist3r...\n"
                if check_and_install_tool "sublist3r" "sudo apt-get install -y sublist3r"; then
                    read -rp "Enter domain: " domain
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running Sublist3r...\n"
                    sublist3r -d "$domain"
                fi
                ;;
            7)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking TheHarvester...\n"
                if check_and_install_tool "theHarvester" "sudo apt-get install -y theharvester"; then
                    read -rp "Enter domain: " domain
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running TheHarvester...\n"
                    theHarvester -d "$domain" -b all
                fi
                ;;
            8)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Dirbuster...\n"
                if check_and_install_tool "dirb" "sudo apt-get install -y dirb"; then
                    read -rp "Enter URL: " url
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running Dirb...\n"
                    dirb "$url"
                fi
                ;;
            9)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking dnsenum...\n"
                if check_and_install_tool "dnsenum" "sudo apt-get install -y dnsenum"; then
                    read -rp "Enter domain: " domain
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running dnsenum...\n"
                    dnsenum "$domain"
                fi
                ;;
            10)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking WhatWeb...\n"
                if check_and_install_tool "whatweb" "sudo apt-get install -y whatweb"; then
                    read -rp "Enter URL: " url
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running WhatWeb...\n"
                    whatweb "$url"
                fi
                ;;
            99)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Returning to Main Menu...\n"
                sleep 1
                clear
                return
                ;;
            *)
                echo -e "\n${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Invalid selection${RESET}\n"
                sleep 1
                clear
                ;;
        esac
        
        echo ""
        read -rp "${BRIGHT_BLUE}Press Enter to continue..."
        clear
        return
    done
}


#CHOICE 2: Vulnerability Scanning
vulnerability_menu(){
    clear
    display_ascii_info
    echo -e "${BRIGHT_RED}"
    echo ""
    echo ""
    echo "      ╔══════════════════════════════════════════════╗"
    echo "      ║${RESET}     ${BRIGHT_BLUE}▓▒░  VULNERABILITY SCANNING  ░▒▓${BRIGHT_RED}         ║"
    echo "      ╚══════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -e "       System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
    echo ""
    echo -e "        ${BRIGHT_BLUE}┌─                                      ─┐${RESET}"
    echo ""

    local options=(
        "1) Nikto"
        "2) Nuclei"
        "3) Wapiti"
        "4) SQLMap"
        "5) XSStrike"
        "6) Commix"
        "7) WPScan"
        "99) Back to Main Menu"
    )
    
    for option in "${options[@]}"; do
        echo -e "            ${RED}[${option%%)*}]${RESET} ${BRIGHT_BLUE}${option#*)}${RESET}"
    done
    
    echo ""
    echo -e "        ${BRIGHT_BLUE}└──                                    ──┘${RESET}"
    echo ""
    
    while true; do
        read -rp " ${BRIGHT_BLUE}user@nexus:~${RESET}${BRIGHT_RED}\$${RESET} " sub_choice
        
        case $sub_choice in
            1)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Nikto...\n"
                if check_and_install_tool "nikto" "sudo apt-get install -y nikto"; then
                    read -rp "Enter target URL: " target
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running Nikto web scanner...\n"
                    nikto -h "$target"
                fi
                ;;
            2)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Nuclei...\n"
                if ! command -v nuclei &> /dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Nuclei is not installed.${RESET}"
                    read -rp "Would you like to install it? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing Nuclei from GitHub...\n"
                        if command -v go &> /dev/null; then
                            go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
                            export PATH=$PATH:~/go/bin
                        else
                            echo -e "${BRIGHT_RED}[!]${RESET} Go is not installed. Installing via apt...\n"
                            sudo apt-get install -y golang-go
                            go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
                            export PATH=$PATH:~/go/bin
                        fi
                    fi
                fi
                if command -v nuclei &> /dev/null || [ -f ~/go/bin/nuclei ]; then
                    read -rp "Enter target URL: " target
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running Nuclei vulnerability scanner...\n"
                    ~/go/bin/nuclei -u "$target" -severity critical,high,medium
                fi
                ;;
            3)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Wapiti...\n"
                if check_and_install_tool "wapiti" "sudo apt-get install -y wapiti"; then
                    read -rp "Enter target URL: " target
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running Wapiti web application scanner...\n"
                    wapiti -u "$target"
                fi
                ;;
            4)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking SQLMap...\n"
                if check_and_install_tool "sqlmap" "sudo apt-get install -y sqlmap"; then
                    read -rp "Enter target URL: " target
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running SQLMap for SQL injection testing...\n"
                    sqlmap -u "$target" --batch --random-agent
                fi
                ;;
            5)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking XSStrike...\n"
                if [ ! -d ~/tools/XSStrike ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}XSStrike is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning XSStrike from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/s0md3v/XSStrike.git ~/tools/XSStrike
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing dependencies...\n"
                        pip3 install -r ~/tools/XSStrike/requirements.txt
                    fi
                fi
                if [ -d ~/tools/XSStrike ]; then
                    read -rp "Enter target URL: " target
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running XSStrike for XSS detection...\n"
                    python3 ~/tools/XSStrike/xsstrike.py -u "$target"
                fi
                ;;
            6)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Commix...\n"
                if [ ! -d ~/tools/commix ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Commix is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning Commix from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/commixproject/commix.git ~/tools/commix
                        chmod +x ~/tools/commix/commix.py
                    fi
                fi
                if [ -d ~/tools/commix ]; then
                    read -rp "Enter target URL: " target
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running Commix for command injection...\n"
                    python3 ~/tools/commix/commix.py --url="$target" --batch
                fi
                ;;
            7)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking WPScan...\n"
                if ! command -v wpscan &> /dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}WPScan is not installed.${RESET}"
                    read -rp "Would you like to install it? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing WPScan...\n"
                        sudo gem install wpscan
                    fi
                fi
                if command -v wpscan &> /dev/null; then
                    read -rp "Enter WordPress URL: " target
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running WPScan for WordPress vulnerabilities...\n"
                    wpscan --url "$target" --enumerate vp,vt,u
                fi
                ;;
            99)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Returning to Main Menu...\n"
                sleep 1
                clear
                return
                ;;
            *)
                echo -e "\n${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Invalid selection${RESET}\n"
                sleep 1
                clear
                ;;
        esac
        
        echo ""
        read -rp "${BRIGHT_BLUE}Press Enter to continue...${RESET}"
        clear
        return
    done
}

# CHOICE 3: Exploitation Framework
exploitation_menu(){
    clear
    display_ascii_info
    echo -e "${BRIGHT_RED}"
    echo ""
    echo ""
    echo "      ╔══════════════════════════════════════════════╗"
    echo "      ║${RESET}     ${BRIGHT_BLUE}▓▒░  EXPLOITATION FRAMEWORK  ░▒▓${BRIGHT_RED}         ║"
    echo "      ╚══════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -e "       System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
    echo ""
    echo -e "        ${BRIGHT_BLUE}┌─                                      ─┐${RESET}"
    echo ""

    local options=(
        "1) Metasploit Framework"
        "2) SearchSploit"
        "3) RouterSploit"
        "4) BeEF"
        "5) AutoSploit"
        "6) SPARTA"
        "7) Sn1per"
        "99) Back to Main Menu"
    )
    
    for option in "${options[@]}"; do
        echo -e "            ${RED}[${option%%)*}]${RESET} ${BRIGHT_BLUE}${option#*)}${RESET}"
    done
    
    echo ""
    echo -e "        ${BRIGHT_BLUE}└──                                    ──┘${RESET}"
    echo ""
    
    while true; do
        read -rp " ${BRIGHT_BLUE}user@nexus:~${RESET}${BRIGHT_RED}\$${RESET} " sub_choice
        
        case $sub_choice in
            1)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Metasploit Framework...\n"
                if ! command -v msfconsole &> /dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Metasploit is not installed.${RESET}"
                    read -rp "Would you like to install it? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing Metasploit Framework...\n"
                        curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
                        chmod 755 msfinstall
                        sudo ./msfinstall
                        rm msfinstall
                    fi
                fi
                if command -v msfconsole &> /dev/null; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Launching Metasploit Console...\n"
                    msfconsole
                fi
                ;;
            2)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking SearchSploit...\n"
                if ! command -v searchsploit &> /dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}SearchSploit is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning ExploitDB from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/offensive-security/exploitdb.git ~/tools/exploitdb
                        sudo ln -sf ~/tools/exploitdb/searchsploit /usr/local/bin/searchsploit
                    fi
                fi
                if command -v searchsploit &> /dev/null; then
                    read -rp "Enter search keyword: " keyword
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Searching ExploitDB for: $keyword\n"
                    searchsploit "$keyword"
                fi
                ;;
            3)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking RouterSploit...\n"
                if [ ! -d ~/tools/routersploit ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}RouterSploit is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning RouterSploit from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/threat9/routersploit ~/tools/routersploit
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing dependencies...\n"
                        cd ~/tools/routersploit
                        pip3 install -r requirements.txt
                        cd -
                    fi
                fi
                if [ -d ~/tools/routersploit ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Launching RouterSploit Framework...\n"
                    cd ~/tools/routersploit
                    python3 rsf.py
                    cd -
                fi
                ;;
            4)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking BeEF (Browser Exploitation Framework)...\n"
                if [ ! -d ~/tools/beef ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}BeEF is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning BeEF from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/beefproject/beef ~/tools/beef
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing dependencies...\n"
                        cd ~/tools/beef
                        sudo apt-get install -y ruby ruby-dev libsqlite3-dev
                        sudo gem install bundler
                        bundle install
                        cd -
                    fi
                fi
                if [ -d ~/tools/beef ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Starting BeEF Server...\n"
                    echo -e "${BRIGHT_BLUE}Default credentials: beef:beef${RESET}"
                    echo -e "${BRIGHT_BLUE}Access at: http://127.0.0.1:3000/ui/panel${RESET}\n"
                    cd ~/tools/beef
                    ./beef
                    cd -
                fi
                ;;
            5)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking AutoSploit...\n"
                if [ ! -d ~/tools/AutoSploit ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}AutoSploit is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning AutoSploit from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/NullArray/AutoSploit.git ~/tools/AutoSploit
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing dependencies...\n"
                        cd ~/tools/AutoSploit
                        pip3 install -r requirements.txt
                        cd -
                    fi
                fi
                if [ -d ~/tools/AutoSploit ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Launching AutoSploit...\n"
                    echo -e "${BRIGHT_BLUE}Note: Requires Metasploit installed${RESET}\n"
                    cd ~/tools/AutoSploit
                    python3 autosploit.py
                    cd -
                fi
                ;;
            6)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking SPARTA...\n"
                if [ ! -d ~/tools/sparta ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}SPARTA is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ses])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning SPARTA from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/SECFORCE/sparta.git ~/tools/sparta
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing dependencies...\n"
                        sudo apt-get install -y python3-pyqt5 python3-sqlalchemy python3-pyqt5.qtwebkit ldap-utils rwho rsh-client x11-apps finger
                    fi
                fi
                if [ -d ~/tools/sparta ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Launching SPARTA GUI...\n"
                    cd ~/tools/sparta
                    sudo python3 sparta.py
                    cd -
                fi
                ;;
            7)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Sn1per...\n"
                if ! command -v sniper &> /dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Sn1per is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning Sn1per from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/1N3/Sn1per ~/tools/Sn1per
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing Sn1per (this may take a while)...\n"
                        cd ~/tools/Sn1per
                        sudo bash install.sh
                        cd -
                    fi
                fi
                if command -v sniper &> /dev/null; then
                    read -rp "Enter target (IP/domain): " target
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running Sn1per scan on: $target\n"
                    sudo sniper -t "$target"
                fi
                ;;
            99)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Returning to Main Menu...\n"
                sleep 1
                clear
                return
                ;;
            *)
                echo -e "\n${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Invalid selection${RESET}\n"
                sleep 1
                clear
                ;;
        esac
        
        echo ""
        read -rp "${BRIGHT_BLUE}Press Enter to continue...${RESET}"
        clear
        return
    done
}


# CHOICE 4: Post-Exploitation
postexploitation_menu(){
    clear
    display_ascii_info
    echo -e "${BRIGHT_RED}"
    echo ""
    echo ""
    echo "      ╔══════════════════════════════════════════════╗"
    echo "      ║${RESET}      ${BRIGHT_BLUE}▓▒░  POST-EXPLOITATION  ░▒▓${BRIGHT_RED}          ║"
    echo "      ╚══════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -e "       System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
    echo ""
    echo -e "        ${BRIGHT_BLUE}┌─                                      ─┐${RESET}"
    echo ""

    local options=(
        "1) LinPEAS/WinPEAS"
        "2) LaZagne"
        "3) Mimikatz"
        "4) Evil-WinRM"
        "5) PowerSploit"
        "6) Linux Smart Enumeration"
        "7) Impacket"
        "99) Back to Main Menu"
    )
    
    for option in "${options[@]}"; do
        echo -e "            ${RED}[${option%%)*}]${RESET} ${BRIGHT_BLUE}${option#*)}${RESET}"
    done
    
    echo ""
    echo -e "        ${BRIGHT_BLUE}└──                                    ──┘${RESET}"
    echo ""
    
    while true; do
        read -rp " ${BRIGHT_BLUE}user@nexus:~${RESET}${BRIGHT_RED}\$${RESET} " sub_choice
        
        case $sub_choice in
            1)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking PEASS-ng (LinPEAS/WinPEAS)...\n"
                if [ ! -d ~/tools/PEASS-ng ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}PEASS-ng is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning PEASS-ng from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/carlospolop/PEASS-ng.git ~/tools/PEASS-ng
                    fi
                fi
                if [ -d ~/tools/PEASS-ng ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} PEASS-ng Tools Available:\n"
                    echo -e "${BRIGHT_BLUE}[1]${RESET} LinPEAS (Linux)"
                    echo -e "${BRIGHT_BLUE}[2]${RESET} WinPEAS (Windows)"
                    echo -e "${BRIGHT_BLUE}[3]${RESET} Show scripts location"
                    read -rp "Select option: " peass_choice
                    case $peass_choice in
                        1)
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Running LinPEAS...\n"
                            cd ~/tools/PEASS-ng/linPEAS
                            chmod +x linpeas.sh
                            ./linpeas.sh
                            cd -
                            ;;
                        2)
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} WinPEAS location:\n"
                            echo -e "${BRIGHT_BLUE}~/tools/PEASS-ng/winPEAS/winPEASexe/binaries/x64/Release/winPEASx64.exe${RESET}"
                            echo -e "${BRIGHT_BLUE}Transfer this file to target Windows machine${RESET}\n"
                            ;;
                        3)
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} PEASS Scripts Location:\n"
                            echo -e "${BRIGHT_BLUE}LinPEAS: ~/tools/PEASS-ng/linPEAS/linpeas.sh${RESET}"
                            echo -e "${BRIGHT_BLUE}WinPEAS: ~/tools/PEASS-ng/winPEAS/winPEASexe/binaries/${RESET}\n"
                            ;;
                    esac
                fi
                ;;
            2)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking LaZagne...\n"
                if [ ! -d ~/tools/LaZagne ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}LaZagne is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning LaZagne from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/AlessandroZ/LaZagne.git ~/tools/LaZagne
                    fi
                fi
                if [ -d ~/tools/LaZagne ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} LaZagne Password Recovery:\n"
                    echo -e "${BRIGHT_BLUE}[1]${RESET} Run LaZagne (Linux)"
                    echo -e "${BRIGHT_BLUE}[2]${RESET} Show Windows binary location"
                    read -rp "Select option: " laz_choice
                    case $laz_choice in
                        1)
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Running LaZagne on Linux...\n"
                            cd ~/tools/LaZagne/Linux
                            python3 laZagne.py all
                            cd -
                            ;;
                        2)
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Windows LaZagne location:\n"
                            echo -e "${BRIGHT_BLUE}~/tools/LaZagne/Windows/laZagne.exe${RESET}"
                            echo -e "${BRIGHT_BLUE}Transfer to Windows and run: laZagne.exe all${RESET}\n"
                            ;;
                    esac
                fi
                ;;
            3)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Mimikatz...\n"
                if [ ! -d ~/tools/mimikatz ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Mimikatz is not installed.${RESET}"
                    read -rp "Would you like to download it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Downloading Mimikatz from GitHub...\n"
                        mkdir -p ~/tools/mimikatz
                        cd ~/tools/mimikatz
                        wget https://github.com/gentilkiwi/mimikatz/releases/latest/download/mimikatz_trunk.zip
                        unzip mimikatz_trunk.zip
                        rm mimikatz_trunk.zip
                        cd -
                    fi
                fi
                if [ -d ~/tools/mimikatz ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Mimikatz Information:\n"
                    echo -e "${BRIGHT_BLUE}Location: ~/tools/mimikatz/x64/mimikatz.exe${RESET}"
                    echo -e "${BRIGHT_BLUE}Transfer to Windows target and run${RESET}"
                    echo -e "${BRIGHT_BLUE}Common commands:${RESET}"
                    echo -e "  - privilege::debug"
                    echo -e "  - sekurlsa::logonpasswords"
                    echo -e "  - lsadump::sam\n"
                fi
                ;;
            4)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Evil-WinRM...\n"
                if ! command -v evil-winrm &> /dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Evil-WinRM is not installed.${RESET}"
                    read -rp "Would you like to install it? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing Evil-WinRM...\n"
                        sudo apt-get install -y ruby ruby-dev libssl-dev libxml2-dev libxslt1-dev
                        sudo gem install evil-winrm
                    fi
                fi
                if command -v evil-winrm &> /dev/null; then
                    read -rp "Enter target IP: " target_ip
                    read -rp "Enter username: " username
                    read -rp "Enter password (or press Enter for hash): " password
                    if [ -z "$password" ]; then
                        read -rp "Enter NTLM hash: " hash
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Connecting to $target_ip with hash...\n"
                        evil-winrm -i "$target_ip" -u "$username" -H "$hash"
                    else
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Connecting to $target_ip...\n"
                        evil-winrm -i "$target_ip" -u "$username" -p "$password"
                    fi
                fi
                ;;
            5)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking PowerSploit...\n"
                if [ ! -d ~/tools/PowerSploit ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}PowerSploit is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning PowerSploit from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/PowerShellMafia/PowerSploit.git ~/tools/PowerSploit
                    fi
                fi
                if [ -d ~/tools/PowerSploit ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} PowerSploit Modules:\n"
                    echo -e "${BRIGHT_BLUE}Location: ~/tools/PowerSploit/${RESET}"
                    echo -e "${BRIGHT_BLUE}Available modules:${RESET}"
                    echo -e "  - CodeExecution/"
                    echo -e "  - ScriptModification/"
                    echo -e "  - Persistence/"
                    echo -e "  - AntivirusBypass/"
                    echo -e "  - Exfiltration/"
                    echo -e "  - Mayhem/"
                    echo -e "  - Privesc/"
                    echo -e "  - Recon/\n"
                    echo -e "${BRIGHT_BLUE}Usage: Import-Module ~/tools/PowerSploit/[Module]/[Script].ps1${RESET}\n"
                fi
                ;;
            6)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Linux Smart Enumeration...\n"
                if [ ! -d ~/tools/linux-smart-enumeration ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Linux Smart Enumeration is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning Linux Smart Enumeration from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/diego-treitos/linux-smart-enumeration.git ~/tools/linux-smart-enumeration
                        chmod +x ~/tools/linux-smart-enumeration/lse.sh
                    fi
                fi
                if [ -d ~/tools/linux-smart-enumeration ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running Linux Smart Enumeration...\n"
                    echo -e "${BRIGHT_BLUE}[0]${RESET} Level 0 - Basic enumeration"
                    echo -e "${BRIGHT_BLUE}[1]${RESET} Level 1 - Interesting info"
                    echo -e "${BRIGHT_BLUE}[2]${RESET} Level 2 - Complete scan"
                    read -rp "Select level (0-2): " level
                    cd ~/tools/linux-smart-enumeration
                    ./lse.sh -l "$level"
                    cd -
                fi
                ;;
            7)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Impacket...\n"
                if ! python3 -c "import impacket" 2>/dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Impacket is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing Impacket...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/fortra/impacket.git ~/tools/impacket
                        cd ~/tools/impacket
                        pip3 install .
                        cd -
                    fi
                fi
                if python3 -c "import impacket" 2>/dev/null; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Impacket Tools:\n"
                    echo -e "${BRIGHT_BLUE}[1]${RESET} psexec.py - Remote command execution"
                    echo -e "${BRIGHT_BLUE}[2]${RESET} secretsdump.py - Dump credentials"
                    echo -e "${BRIGHT_BLUE}[3]${RESET} GetNPUsers.py - AS-REP Roasting"
                    echo -e "${BRIGHT_BLUE}[4]${RESET} GetUserSPNs.py - Kerberoasting"
                    echo -e "${BRIGHT_BLUE}[5]${RESET} Show all tools"
                    read -rp "Select option: " imp_choice
                    case $imp_choice in
                        1)
                            read -rp "Enter target (IP or domain): " target
                            read -rp "Enter username: " user
                            read -rp "Enter password: " pass
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Running psexec...\n"
                            impacket-psexec "$user:$pass@$target"
                            ;;
                        2)
                            read -rp "Enter target (IP or domain): " target
                            read -rp "Enter username: " user
                            read -rp "Enter password: " pass
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Dumping credentials...\n"
                            impacket-secretsdump "$user:$pass@$target"
                            ;;
                        3)
                            read -rp "Enter domain: " domain
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Running AS-REP Roasting...\n"
                            impacket-GetNPUsers "$domain/" -no-pass -usersfile users.txt
                            ;;
                        4)
                            read -rp "Enter domain: " domain
                            read -rp "Enter username: " user
                            read -rp "Enter password: " pass
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Running Kerberoasting...\n"
                            impacket-GetUserSPNs "$domain/$user:$pass" -request
                            ;;
                        5)
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Available Impacket Tools:\n"
                            ls /usr/local/bin/impacket-* 2>/dev/null || ls ~/.local/bin/impacket-* 2>/dev/null
                            ;;
                    esac
                fi
                ;;
            99)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Returning to Main Menu...\n"
                sleep 1
                clear
                return
                ;;
            *)
                echo -e "\n${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Invalid selection${RESET}\n"
                sleep 1
                clear
                ;;
        esac
        
        echo ""
        read -rp "${BRIGHT_BLUE}Press Enter to continue...${RESET}"
        clear
        return
    done
}






#MAIN SELECTION HANDLER

handle_selection() {
    case $1 in
        1)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Initializing NETWORK RECONNAISSANCE...\n"
            sleep 1
            network_reconnaissance_menu
            ;;
        2)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Launching VULNERABILITY SCANNER...\n"
            sleep 1
            vulnerability_menu
            ;;
        3)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Loading EXPLOITATION FRAMEWORK...\n"
            sleep 1
            exploitation_menu
            ;;
        4)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Activating POST-EXPLOITATION modules...\n"
            sleep 1
            postexploitation_menu
            ;;
        5)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Starting CREDENTIAL HARVESTER...\n"
            sleep 1
            ;;
        6)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Generating PAYLOAD...\n"
            sleep 1
            ;;
        7)
            echo -e "\n${BRIGHT_RED}[◆] SYSTEM SHUTDOWN${RESET}\n"
            echo -e "${BRIGHT_BLUE}Closing connection...${RESET}\n"
            sleep 1
            clear
            exit 0
            ;;
        *)
            echo -e "\n${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Invalid selection${RESET}\n"
            sleep 1
            clear
            ;;
    esac
}


Main_Loop(){
    # Main loop
    clear
    while true; do
    display_ascii_info
    display_menu
    read -rp " ${BRIGHT_BLUE}user@nexus:~${RESET}${BRIGHT_RED}\$${RESET} " choice
    handle_selection "$choice"
done
}

Main_Loop