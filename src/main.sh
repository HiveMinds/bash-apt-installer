#!/bin/bash

# This module is a dependency for:
PACKAGE_INSTALLER_PARENT_DEPS=("bash-create-onion-domains" "bash-ssh-over-tor" "bash-start-tor-at-boot")
# This module has dependencies:
PACKAGE_INSTALLER_REQUIRED_DEPS=("bash-log")

PACKAGE_INSTALLER_SRC_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
PACKAGE_INSTALLER_PATH=$(readlink -f "$PACKAGE_INSTALLER_SRC_PATH/../")

# Loads the bash log dependency, and the dependency loader.
function load_dependency_manager() {
  if [ -d "$PACKAGE_INSTALLER_PATH/dependencies/bash-log" ]; then
    # shellcheck disable=SC1091
    source "$PACKAGE_INSTALLER_PATH/dependencies/bash-log/src/main.sh"
  elif [ -d "$PACKAGE_INSTALLER_PATH/../bash-log" ]; then
    # shellcheck disable=SC1091
    source "$PACKAGE_INSTALLER_PATH/../bash-log/src/main.sh"
  else
    echo "ERROR: bash-log dependency is not found."
    exit 1
  fi
}
load_dependency_manager

# Load required dependencies.
for required_dependency in "${PACKAGE_INSTALLER_REQUIRED_DEPS[@]}"; do
  load_required_dependency "$START_TOR_AT_BOOT_PATH" "$required_dependency"
done

# Load dependencies that can be a parent dependency (=this module is a
# dependency of that module/dependency).
for parent_dep in "${PACKAGE_INSTALLER_PARENT_DEPS[@]}"; do
  load_parent_dependency "calling_repo_root_path" "$START_TOR_AT_BOOT_PATH" "$parent_dep"
done

LOG_LEVEL_ALL # set log level to all, otherwise, NOTICE, INFO, DEBUG, TRACE will not be logged.
B_LOG --file log/multiple-outputs.txt --file-prefix-enable --file-suffix-enable

# TODO: move into globals.
# shellcheck disable=SC2034
VENV_NAME="automated-pip-venv"

function load_functions() {
  # shellcheck disable=SC1091
  source "$PACKAGE_INSTALLER_SRC_PATH/parsing_helper.sh"

  # shellcheck disable=SC1091
  source "$PACKAGE_INSTALLER_SRC_PATH/installation/install_apt.sh"
  # shellcheck disable=SC1091
  source "$PACKAGE_INSTALLER_SRC_PATH/installation/install_pip.sh"
  # shellcheck disable=SC1091
  source "$PACKAGE_INSTALLER_SRC_PATH/installation/install_snap.sh"

  # shellcheck disable=SC1091
  source "$PACKAGE_INSTALLER_SRC_PATH/uninstallation/uninstall_apt.sh"
  # shellcheck disable=SC1091
  source "$PACKAGE_INSTALLER_SRC_PATH/uninstallation/uninstall_pip.sh"
  # shellcheck disable=SC1091
  source "$PACKAGE_INSTALLER_SRC_PATH/uninstallation/uninstall_snap.sh"
}
load_functions
