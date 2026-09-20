![Banner](https://github.com/user-attachments/assets/dde10d8c-7d47-45a0-ac8b-47edb927d290)

# Welcome, Cyberpsycho

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Shellcheck](https://img.shields.io/badge/lint-shellcheck-informational.svg)](https://www.shellcheck.net/)

**SANDEVISTAN** puts every phase of an engagement, recon, exploitation and
post-exploitation, behind one cyberpunk menu. Pick a target, pick a tool, go,
no juggling a dozen scripts and tabs.

## Quick start

```bash
git clone https://github.com/WhiteMuush/sandevistan.git
cd sandevistan && chmod +x sandevistan.sh
./sandevistan.sh
```

Runs natively on Debian/Kali. On Fedora, Arch, openSUSE or an atomic distro
(Bazzite, Silverblue) it offers a shared Debian box (podman/docker) and installs
each tool the first time you pick it. Inside that box scans fall back to an
unprivileged connect scan automatically, so nmap never dies on a missing raw
socket. See [docs/DISTRO_COMPAT.md](docs/DISTRO_COMPAT.md).

> **Heads-up:** SANDEVISTAN drives third-party tools and asks before every install.

![Interface](https://github.com/user-attachments/assets/5a3b8559-ba52-42b7-92b2-4a4a2bd3026c)

## Six modules

Each opens a numbered menu; tools install on first use.

| Module | Tools |
|---|---|
| **Recon** | Nmap, Masscan, Recon-ng, Amass, Sublist3r, theHarvester, dirb, dnsenum, WhatWeb |
| **Vulnerability** | Nikto, Nuclei, Wapiti, sqlmap, XSStrike, Commix, WPScan |
| **Exploitation** | Metasploit, SearchSploit, RouterSploit, BeEF, AutoSploit, SPARTA, Sn1per |
| **Post-exploitation** | LinPEAS/WinPEAS, LaZagne, Mimikatz, Evil-WinRM, PowerSploit, LSE, Impacket |
| **Credentials** | hashcat, John the Ripper, Hydra, NetExec, Responder, CredMaster, BruteSpray |
| **Payloads** | msfvenom, Veil, TheFatRat, Shellter, Hoaxshell, Donut, ScareCrow |

## Engagement workspace

Every run opens a timestamped workspace (`loot/`, `output/`, `logs/`) and mirrors
a plain, greppable log (`[ISO-8601] [LEVEL] message`) to `logs/session.log`, with
each tool's raw output captured under `output/`. Git-cloned tools land in `~/tools`
by default (override with `SANDEVISTAN_TOOLS_DIR`).

<img width="1678" height="1022" alt="Sandevistan tools" src="https://github.com/user-attachments/assets/f035cf9c-6e55-460e-a731-29a5b996ad85" />

## Project layout

```
sandevistan/
├── sandevistan.sh     # thin entry point
├── lib/
│   ├── core.sh        # colors, constants
│   ├── ui.sh          # ASCII art, banners
│   ├── installer.sh   # install / prompt / logging helpers
│   ├── logger.sh      # timestamped, greppable logging
│   ├── session.sh     # engagement workspace
│   ├── compat.sh      # native-or-box runtime (shared module)
│   └── modules/       # one file per module
└── docs/              # ARCHITECTURE.md, ADDING_A_TOOL.md, DISTRO_COMPAT.md
```

## Contributing

PRs welcome, see [CONTRIBUTING.md](CONTRIBUTING.md) and
[docs/ADDING_A_TOOL.md](docs/ADDING_A_TOOL.md). The codebase is small and
predictable on purpose: a new tool is usually one focused PR, with `bats` tests
and a clean `shellcheck`. Bug reports and tool requests use the issue templates.

## License

[MIT](LICENSE). Use, modify and distribute freely, but credit the original
authors (Melvin PETIT / WhiteMuush).

## Security

Found a vulnerability? Follow the responsible-disclosure process in
[SECURITY.md](SECURITY.md), do **not** open a public issue.

## Disclaimer

For **educational purposes and authorized security testing only**. Use at your
own risk: get explicit permission and comply with all applicable laws. The
authors accept no liability for misuse or damage. No warranties, express or implied.

## Linktree

<https://linktr.ee/melvinpetit>

### Thank you!
