#!/bin/bash
echo "$PWD"

# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/installation/install_apt.sh"
# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/installation/install_pip.sh"
# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/installation/install_snap.sh"

# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/logging/cli_logging.sh"

# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/uninstallation/uninstall_apt.sh"
# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/uninstallation/uninstall_pip.sh"
# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/uninstallation/uninstall_snap.sh"

ensure_pip_pkg "twine"
pip_remove "twine"
