#!/bin/bash

# Get the path towards this src dir.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/installation/install_apt.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/installation/install_pip.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/installation/install_snap.sh"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/logging/cli_logging.sh"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/uninstallation/uninstall_apt.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/uninstallation/uninstall_pip.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/uninstallation/uninstall_snap.sh"
