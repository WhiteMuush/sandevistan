# Contributing to SANDEVISTAN

Thanks for your interest in improving SANDEVISTAN! This document explains how
to get a local environment running, how the project is laid out and what we
look for in a Pull Request.

## Code of conduct

This project adopts the [Contributor Covenant](CODE_OF_CONDUCT.md). By
participating you agree to abide by it.

## Quick orientation

```
sandevistan/
├── sandevistan.sh         # Thin entry point
├── lib/
│   ├── core.sh            # Colors, constants, project metadata
│   ├── ui.sh              # ASCII art, banners, menu rendering
│   ├── installer.sh       # Install / prompt / logging helpers
│   └── modules/
│       ├── recon.sh
│       ├── vulnerability.sh
│       ├── exploitation.sh
│       ├── postexploit.sh
│       ├── credentials.sh
│       └── payload.sh
└── docs/
    ├── ARCHITECTURE.md
    └── ADDING_A_TOOL.md
```

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the full design and
[docs/ADDING_A_TOOL.md](docs/ADDING_A_TOOL.md) for a step-by-step recipe to
contribute a new tool.

## Development setup

Requirements:

- `bash` 5.x (the project targets modern Linux distros — Kali, Parrot, Ubuntu, …)
- `shellcheck` for local linting
- `git`

```bash
git clone https://github.com/WhiteMuush/sandevistan.git
cd sandevistan
chmod +x sandevistan.sh
./sandevistan.sh
```

To validate locally before opening a PR:

```bash
# Syntax check every shell script
find . -type f -name '*.sh' -exec bash -n {} +

# Lint
shellcheck sandevistan.sh lib/**/*.sh
```

Both checks are also enforced in CI.

## Coding conventions

- **Shebang**: `#!/usr/bin/env bash`
- **Strict-ish mode**: `set -uo pipefail` at the top of every executable
  script. We avoid `set -e` because the interactive loop must survive
  commands that exit non-zero (cancelled prompts, failed scans, …).
- **Quoting**: always quote variable expansions — `"${var}"`, not `$var`.
- **Indentation**: 4 spaces, no tabs (enforced by `.editorconfig`).
- **Naming**:
  - functions: `snake_case`
  - private/internal globals: `SANDEVISTAN_*`
  - tool runners: `<module>_run_<tool>` (e.g., `recon_run_nmap`)
  - menu dispatchers: `<module>_menu` or `<module>tion_menu` as used today
- **Logging**: prefer `log_info`, `log_step`, `log_warn`, `log_success`,
  `log_error` from `lib/installer.sh` rather than raw `echo`.
- **Installation**: prefer `ensure_command` (binary on PATH) or
  `ensure_repo` (git-cloned tool) over reimplementing the prompt-then-install
  dance.

## Pull Request checklist

- [ ] Targets `main` (or `master`, whichever the repo uses)
- [ ] Commits are focused and have meaningful messages
- [ ] Code passes `bash -n` and `shellcheck`
- [ ] Tested manually on a recent Kali/Parrot/Ubuntu
- [ ] Documentation updated (README, `docs/`, in-file comments where needed)
- [ ] No secrets, hard-coded credentials or pre-set targets committed

A PR template is provided automatically by GitHub — please fill it in.

## Reporting bugs

Use the GitHub issue tracker with the **Bug report** template. Please include:

- Distribution and version (`lsb_release -a`)
- Bash version (`bash --version`)
- Steps to reproduce
- Expected vs. actual behaviour

## Reporting security issues

Do **not** open a public issue for security vulnerabilities — see
[SECURITY.md](SECURITY.md) for the disclosure process.

## License

By contributing, you agree that your contributions will be licensed under the
MIT License (see [LICENSE](LICENSE)).
