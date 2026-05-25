#!/usr/bin/env bash
# lib/ui.sh — ASCII art, banners and menu rendering.
# Source-only file. Depends on lib/core.sh.

if [[ -n "${SANDEVISTAN_UI_LOADED:-}" ]]; then
    return 0
fi
SANDEVISTAN_UI_LOADED=1

# shellcheck source=core.sh
[[ -z "${SANDEVISTAN_CORE_LOADED:-}" ]] && {
    echo "lib/ui.sh: lib/core.sh must be sourced first" >&2
    return 1
}

# ASCII art shown on every menu.
read -r -d '' SANDEVISTAN_ASCII_ART << 'EOF' || true
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

SANDEVISTAN_INFO_LIST=(
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

# Render the ASCII art side-by-side with the info banner.
display_ascii_info() {
    local -a info_lines ascii_lines
    info_lines=("${SANDEVISTAN_INFO_LIST[@]}")
    local IFS=$'\n'
    read -d '' -r -a ascii_lines <<< "$SANDEVISTAN_ASCII_ART" || true
    unset IFS

    local ascii_count=${#ascii_lines[@]}
    local info_count=${#info_lines[@]}
    local vertical_offset=$(((ascii_count - info_count) / 2))

    local max_width=0 line
    for line in "${ascii_lines[@]}"; do
        ((${#line} > max_width)) && max_width=${#line}
    done

    local spacing="  "
    local i ascii_line colored_ascii colored_info info_idx info_line pad label value

    for ((i = 0; i < ascii_count; i++)); do
        ascii_line="${ascii_lines[i]:-}"
        colored_ascii="${BRIGHT_RED}${ascii_line}${RESET}"
        colored_info=""

        if ((i >= vertical_offset && i < vertical_offset + info_count)); then
            info_idx=$((i - vertical_offset))
            info_line="${info_lines[info_idx]:-}"
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
            "   ${colored_ascii}" \
            "$(printf '%*s' "$pad" '')${spacing}${colored_info}"
    done
}

# Draw a stylised banner. Pass the title as the only argument.
draw_banner() {
    local title="$1"
    local title_len=${#title}
    local box_inner=$((title_len + 14))
    local border
    border=$(printf '═%.0s' $(seq 1 "$box_inner"))

    echo -e "${BRIGHT_RED}"
    echo ""
    echo "      ╔${border}╗"
    echo -e "      ║${RESET}     ${BRIGHT_BLUE}▓▒░    ${title}    ░▒▓${BRIGHT_RED}     ║"
    echo "      ╚${border}╝"
    echo -e "${RESET}"
    echo -e "      System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
    echo ""
    echo -e "        ${BRIGHT_BLUE}┌─                                      ─┐${RESET}"
    echo ""
}

# Render the closing line of a banner block.
close_banner() {
    echo ""
    echo -e "        ${BRIGHT_BLUE}└──                                    ──┘${RESET}"
    echo ""
}

# Render a numbered option list. Pass options as "N) Label" strings.
render_options() {
    local option
    for option in "$@"; do
        echo -e "            ${RED}[${option%%)*}]${RESET} ${BRIGHT_BLUE}${option#*)}${RESET}"
    done
}

# Standard interactive prompt rendered in the cyberpunk style.
shell_prompt() {
    printf " %s%s@nexus:~%s%s\$%s " \
        "${BRIGHT_BLUE}" "${SANDEVISTAN_USER}" "${RESET}" \
        "${BRIGHT_RED}" "${RESET}"
}

# Pause until the user presses Enter, then clear the screen.
press_enter_to_continue() {
    echo ""
    # shellcheck disable=SC2162
    read -rp "${BRIGHT_BLUE}Press Enter to continue...${RESET}"
    clear
}

# Render the root menu shown on the main loop.
display_main_menu() {
    local -a menu_items=(
        "NETWORK RECONNAISSANCE"
        "VULNERABILITY SCANNING"
        "EXPLOITATION FRAMEWORK"
        "POST-EXPLOITATION"
        "CREDENTIAL HARVESTING"
        "PAYLOAD GENERATOR"
        "LEAVE"
    )

    echo -e "${BRIGHT_RED}"
    echo ""
    echo ""
    echo "      ╔═══════════════════════════════════════════╗"
    echo -e "      ║${RESET}     ${BRIGHT_BLUE}▓▒░    SANDEVISTAN Toolkit    ░▒▓${BRIGHT_RED}     ║"
    echo "      ╚═══════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo -e "      System: ${BRIGHT_BLUE}OPERATIONAL${RESET}  ${BRIGHT_RED}✞${RESET}  Security Level: ${BRIGHT_RED}MAXIMUM${RESET}"
    echo ""
    echo -e "        ${BRIGHT_BLUE}┌─                                      ─┐${RESET}"
    echo ""

    local i item num
    for i in "${!menu_items[@]}"; do
        item="${menu_items[$i]}"
        num=$((i + 1))
        printf "            ${RED}[%d]${RESET} %s\n" "$num" "  ${BRIGHT_BLUE}${item}${RESET}"
    done

    close_banner
}
