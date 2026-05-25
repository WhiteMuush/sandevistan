![Banner 1](https://github.com/user-attachments/assets/dde10d8c-7d47-45a0-ac8b-47edb927d290)

# Welcome, Cyberpsycho

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Shellcheck](https://img.shields.io/badge/lint-shellcheck-informational.svg)](https://www.shellcheck.net/)

**SANDEVISTAN** is your unified cybersecurity toolkit — a single space where
reconnaissance, exploitation, and post-exploitation tools converge. No more
context switching between dozens of platforms. Everything you need is here,
optimized and ready to deploy.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/WhiteMuush/sandevistan.git
cd sandevistan

# Make the entry point executable and run
chmod +x sandevistan.sh
./sandevistan.sh
```

> **Heads-up:** SANDEVISTAN orchestrates third-party tools and may need
> `sudo` to install them. It will ask for confirmation before each install.

![Banner 2](https://github.com/user-attachments/assets/5a3b8559-ba52-42b7-92b2-4a4a2bd3026c)

## Features

- **All-in-One Arsenal** — Comprehensive suite of security tools in one place
- **Streamlined Workflow** — No more tool hunting; everything at your fingertips
- **Pluggable Architecture** — Add a new tool in one focused PR (see [docs/ADDING_A_TOOL.md](docs/ADDING_A_TOOL.md))
- **Easy Deployment** — Simple installation, sensible defaults

## 6 Integrated Modules

### Network Reconnaissance
Quick discovery and footprinting to map targets and enumerate services.
- Tools: [Nmap](https://github.com/nmap/nmap), [Masscan](https://github.com/robertdavidgraham/masscan), [Amass](https://github.com/OWASP/Amass), [Recon-ng](https://github.com/lanmaster53/recon-ng), [Sublist3r](https://github.com/aboul3la/Sublist3r), [theHarvester](https://github.com/laramies/theHarvester), [dnsenum](https://github.com/SparrowOchon/dnsenum2), [WhatWeb](https://github.com/urbanadventurer/WhatWeb), [dirb](https://gitlab.com/kalilinux/packages/dirb)

### Vulnerability Scanning
Automated checks to find common and custom vulnerabilities across web and network surfaces.
- Tools: [Nikto](https://github.com/sullo/nikto), [Nuclei](https://github.com/projectdiscovery/nuclei), [Wapiti](https://github.com/wapiti-scanner/wapiti), [sqlmap](https://github.com/sqlmapproject/sqlmap), [XSStrike](https://github.com/s0md3v/XSStrike), [Commix](https://github.com/commixproject/commix), [WPScan](https://github.com/wpscanteam/wpscan)

### Exploitation Framework
Frameworks and targeted exploit tools for validating vulnerabilities and gaining initial access.
- Tools: [Metasploit Framework](https://github.com/rapid7/metasploit-framework), [SearchSploit](https://gitlab.com/exploit-database/exploitdb), [RouterSploit](https://github.com/threat9/routersploit), [BeEF](https://github.com/beefproject/beef), [AutoSploit](https://github.com/NullArray/AutoSploit), [SPARTA](https://github.com/SECFORCE/sparta), [Sn1per](https://github.com/1N3/Sn1per)

### Post-Exploitation
Tools for lateral movement, persistence, and deeper system enumeration after compromise.
- Tools: [PEASS-ng (LinPEAS / WinPEAS)](https://github.com/carlospolop/PEASS-ng), [LaZagne](https://github.com/AlessandroZ/LaZagne), [Mimikatz](https://github.com/gentilkiwi/mimikatz), [Evil-WinRM](https://github.com/Hackplayers/evil-winrm), [PowerSploit](https://github.com/PowerShellMafia/PowerSploit), [Linux Smart Enumeration](https://github.com/diego-treitos/linux-smart-enumeration), [Impacket](https://github.com/fortra/impacket)

### Credential Harvesting
Password cracking, credential capture, and network credential abuse utilities.
- Tools: [hashcat](https://github.com/hashcat/hashcat), [John the Ripper](https://github.com/openwall/john), [Hydra](https://github.com/vanhauser-thc/thc-hydra), [CrackMapExec / NetExec](https://github.com/Pennyw0rth/NetExec), [Responder](https://github.com/lgandx/Responder), [CredMaster](https://github.com/knavesec/CredMaster), [BruteSpray](https://github.com/x90skysn3k/brutespray)

### Payload Generation
Generators and obfuscators for custom payload creation and delivery.
- Tools: [msfvenom](https://github.com/rapid7/metasploit-framework), [Veil-Framework](https://github.com/Veil-Framework/Veil), [TheFatRat](https://github.com/screetsec/TheFatRat), [Shellter](https://www.shellterproject.com/), [Hoaxshell](https://github.com/t3l3machus/hoaxshell), [Donut](https://github.com/TheWover/donut), [ScareCrow](https://github.com/optiv/ScareCrow)

## A Unique Cyberpunk Interface Style

Experience a visually striking, immersive interface that embodies cyberpunk
aesthetics. Our design combines futuristic elements with a user-friendly
layout so you not only work efficiently but enjoy the process.

<img width="1678" height="1022" alt="Sandevistan tools" src="https://github.com/user-attachments/assets/f035cf9c-6e55-460e-a731-29a5b996ad85" />

## Project Layout

```
sandevistan/
├── sandevistan.sh         # Thin entry point
├── lib/
│   ├── core.sh            # Colors, constants
│   ├── ui.sh              # ASCII art, banners
│   ├── installer.sh       # Install / prompt / logging helpers
│   └── modules/           # One file per module
└── docs/
    ├── ARCHITECTURE.md
    └── ADDING_A_TOOL.md
```

The tools cloned at runtime land in `~/tools` by default. Override with:

```bash
export SANDEVISTAN_TOOLS_DIR=/opt/sandevistan-tools
./sandevistan.sh
```

## Contributing

Pull Requests are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md) and
[docs/ADDING_A_TOOL.md](docs/ADDING_A_TOOL.md). The codebase is intentionally
small and predictable so a new tool integration is usually one focused PR.

Bug reports and tool requests use the GitHub issue templates.

## License

This project is licensed under the [MIT License](LICENSE). Feel free to use,
modify, and distribute it, but please credit the original authors (Melvin
PETIT / WhiteMuush).

## Security

Found a vulnerability? Please follow the responsible-disclosure process in
[SECURITY.md](SECURITY.md) — do **not** open a public issue.

## Disclaimer

This tool is intended for **educational purposes and authorized security
testing only**. Use at your own risk. The authors and contributors accept no
responsibility or liability for any misuse, damages, data loss, service
disruption, or legal consequences resulting from its use. Ensure you have
explicit permission and comply with all applicable laws. No warranties,
express or implied.

## Linktree

<https://linktr.ee/melvinpetit>

### Thank you!
