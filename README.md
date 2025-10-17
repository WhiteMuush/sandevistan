![cyberpunk-edgerunners-sandevistan-2901376262](https://github.com/user-attachments/assets/c9d28e5d-0a96-4791-8020-604afac041b0)

# Sandevistan Toolkit

Terminal-based, menu-driven orchestration for common security reconnaissance tools with a neon HUD and dynamic ASCII panel.

- Host: Relic
- OS: Militech APOGEE SANDEVISTAN (fictional banner)
- Arch: x64
- Author: Melvin PETIT

Note: Use strictly on systems you own or are authorized to test. Educational and lawful security testing only.

## Features

- Dynamic ASCII art and info panel (centered, colorized via tput)
- Main menu with modules:
    - Network Reconnaissance (for now)
    - Vulnerability scanning, exploitation, post-exploitation, credential harvesting, payload generator (placeholders)
- On-demand dependency check-and-install (APT, with user confirmation)
- Clean terminal layout and status banners

## Requirements

- Linux (Debian/Ubuntu/Kali recommended)
- bash 4+
- ncurses/tput
- sudo and internet access (for on-demand installs)
- APT-based system (script uses apt-get)

## Quick start

```bash
# Clone or copy the script into the repo
git clone https://github.com/WhiteMuush/sandevistan.git

# Save as sandevistan.sh
chmod +x sandevistan.sh
./sandevistan.sh
```

- The script will clear the screen, render the ASCII HUD, and display the menu.
- Selecting a tool will check for its presence and optionally install via apt-get.
- Exit via option [7] LEAVE.

## Tools managed (recon module)

- Nmap
- Masscan
- Recon-ng
- Amass
- Sublist3r
- theHarvester
- Dirb
- dnsenum
- WhatWeb

Packages are installed only if missing and you confirm the prompt.

Other Tools coming-soon.

## Known issues and notes

- Missing color: BRIGHT_GREEN is referenced but not defined. Add:
    - BRIGHT_GREEN="${BOLD}$(tput setaf 2)"
- Function typo: netword_reconnaissance should be network_reconnaissance (or fix the call site).
- Submenu numbering gap: option 6 is missing (intentional or to fill later).
- Dirbuster vs dirb: label says Dirbuster but command uses dirb (package: dirb). Adjust text or tool as desired.
- theHarvester: apt package is theharvester, binary is theHarvester (current check likely works on Kali).
- Recursive call in network_reconnaissance_menu:
    - Inside the while loop, after “Press Enter to continue…”, the function calls itself. This nests loops unnecessarily.
    - Fix: remove the line “network_reconnaissance_menu” at the end of that function and rely on the existing while true loop.
- APT-only installs: on non-Debian systems, adapt install commands.

## Customization

- Update info_list to change the right-side panel content.
- Adjust colors by editing the tput-based palette at the top.
- Add modules by expanding MENU_ITEMS and handle_selection cases.

## Legal

This toolkit is for authorized security testing and educational use only. You are responsible for complying with all laws and regulations. Obtain explicit permission before scanning or testing any system.

## License

- No license is currently specified (all rights reserved).
- When referencing this toolkit or related professional work, please credit or tag the author (Melvin PETIT).
