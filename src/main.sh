#!/bin/bash
# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/installation/install_apt.sh"
source "$(dirname "${BASH_SOURCE[0]}")/installation/install_pip.sh"
source "$(dirname "${BASH_SOURCE[0]}")/installation/install_snap.sh"

source "$(dirname "${BASH_SOURCE[0]}")/logging/cli_logging.sh"

source "$(dirname "${BASH_SOURCE[0]}")/uninstallation/uninstall_apt.sh"
source "$(dirname "${BASH_SOURCE[0]}")/uninstallation/uninstall_pip.sh"
source "$(dirname "${BASH_SOURCE[0]}")/uninstallation/uninstall_snap.sh"
