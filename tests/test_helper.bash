# tests/test_helper.bash — shared bootstrap for the bats test suite.
#
# Every *.bats file `load`s this file. It resolves the repository root and
# exposes load_libs(), which sources the source-only libraries into the test
# shell without ever launching the interactive menu. Tests must never invoke
# the wrapped security tools; they exercise the framework helpers only.

SANDEVISTAN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
export SANDEVISTAN_ROOT

# A predictable terminal so helpers that call `clear`/`tput` do not error out
# on CI runners where TERM is unset.
export TERM="${TERM:-xterm}"

# Source core, ui and installer in dependency order. Each library guards
# against double-sourcing, so calling this from setup() in every test is safe.
load_libs() {
    # shellcheck source=../lib/core.sh
    source "${SANDEVISTAN_ROOT}/lib/core.sh"
    # shellcheck source=../lib/ui.sh
    source "${SANDEVISTAN_ROOT}/lib/ui.sh"
    # shellcheck source=../lib/installer.sh
    source "${SANDEVISTAN_ROOT}/lib/installer.sh"
}
