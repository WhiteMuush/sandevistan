# Cross-distro compatibility

The tools SANDEVISTAN wraps (crackmapexec, responder, impacket, metasploit and
friends) are packaged for the Debian/Kali family. Rather than port every tool to
every package manager, the toolkit keeps one target environment and brings it to
the host when needed.

## How it works

At startup `lib/compat.sh` reads `/etc/os-release`:

- **Debian, Ubuntu, Kali, Parrot, Mint** and other Debian derivatives run the
  toolkit **natively**. Nothing changes.
- **Any other distro** (Fedora, Arch, openSUSE, Alpine, atomic distros like
  Bazzite or Silverblue) is offered a container: SANDEVISTAN runs inside one
  shared, lightweight Debian box where `apt` and the tools work as intended.

## The shared box

- Image: `debian:stable-slim` by default (small; tools are pulled on demand).
- One persistent, named container reused by every toolkit that sits under the
  same parent directory, so it is created once and installed tools survive.
- Runtime: **podman** is preferred, **docker** is the fallback.
- On first creation the box is seeded with the essentials (`sudo`, `git`,
  `python3`, `pip`, `pipx`), and you are offered the **Kali repositories** for
  tools missing from Debian.

Bind mounts:

- the toolkits' parent directory at `/opt/toolkits`
- an engagements directory (`~/pentest-engagements` by default) at
  `/root/pentest-engagements`, so loot and reports stay on the host

Both are mounted with the `:z` SELinux label so a rootless container can write
to them on Fedora/Bazzite/RHEL hosts.

## Network and privileges

Real scans and raw-socket tools need the host network, so the box runs with
`--network host` and the `NET_RAW` / `NET_ADMIN` capabilities. This means the
container shares the host's network stack: it is not a sealed sandbox. That is
expected for a pentest tool you launch yourself, but worth knowing.

## Overrides

| Variable | Default | Purpose |
|---|---|---|
| `PENTEST_BOX_NAME` | `pentest-toolbox` | shared container name |
| `PENTEST_BOX_IMAGE` | `debian:stable-slim` | base image (e.g. `kalilinux/kali-rolling`) |
| `PENTEST_ENGAGEMENTS_DIR` | `~/pentest-engagements` | host directory for results |

Set `PENTEST_IN_BOX=1` to force native execution (used automatically inside
the box to avoid re-entering it).
