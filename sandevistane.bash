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
    "Creator: Melvin PETIT"
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
        "1) PROGRAMME 1"
        "2) PROGRAMME 2"
        "3) PROGRAMME 3"
        "4) PROGRAMME 4"
        "5) PROGRAMME 5"
        "6) Back to Main Menu"
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
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Executing Ping Sweep...\n"
                sleep 1
                ;;
            2)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Performing Port Scan...\n"
                sleep 1
                ;;
            3)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Starting Service Enumeration...\n"
                sleep 1
                ;;
            4)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Conducting OS Fingerprinting...\n"
                sleep 1
                ;;
            5)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Mapping Vulnerabilities...\n"
                sleep 1
                ;;
            6)
                echo -e "\n${BRIGHT_RED}[◆]${RESET} Returning to Main Menu...\n"
                sleep 1
                clear
                return

                ;;
            *)
                echo -e "\n${BRIGHT_RED}[!]${RESET} ${BRIGHT_BLUE}Invalid selection${RESET}\n"
                sleep 1
                ;;
        esac
    done

}


netword_reconnaissance() {
    network_reconnaissance_menu
}



#MAIN SELECTIOn HANDLER

handle_selection() {
    case $1 in
        1)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Initializing NETWORK RECONNAISSANCE...\n"
            sleep 1
            netword_reconnaissance
            ;;
        2)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Launching VULNERABILITY SCANNER...\n"
            sleep 1
            ;;
        3)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Loading EXPLOITATION FRAMEWORK...\n"
            sleep 1
            ;;
        4)
            echo -e "\n${BRIGHT_RED}[◆]${RESET} Activating POST-EXPLOITATION modules...\n"
            sleep 1
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
            ;;
    esac
}


Main_Loop(){
    # Main loop
    while true; do
    display_ascii_info
    display_menu
    
    read -rp " ${BRIGHT_BLUE}user@nexus:~${RESET}${BRIGHT_RED}\$${RESET} " choice
    
    handle_selection "$choice"
done
}

Main_Loop