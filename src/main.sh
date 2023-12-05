#!/bin/bash

# This module is a dependency for:
# - bash-create-onion-domains
# - bash-ssh-over-tor
# - bash-start-tor-at-boot
# This module has dependencies:
# - bash-log

PACKAGE_INSTALLER_SRC_PATH=$(dirname "$(readlink -f "$0")")
PACKAGE_INSTALLER_PATH=$(readlink -f "$PACKAGE_INSTALLER_SRC_PATH/../")

function load_dependencies() {
  local dependency_or_parent_path
  # The path of this repo ends in /bash-create-onion-domains. If it follows:
  # /dependencies/bash-create-onion-domains, then it is a dependency of
  #another module.
  echo "PACKAGE_INSTALLER_PATH=$PACKAGE_INSTALLER_PATH"
  if [[ "$PACKAGE_INSTALLER_PATH" == *"/dependencies/bash-create-onion-domains" ]]; then
    # This module is a dependency of another module.
    dependency_or_parent_path=".."
  else
    dependency_or_parent_path="dependencies"
  fi
  echo "dependency_or_parent_path=$dependency_or_parent_path"
  load_required_dependencies "$dependency_or_parent_path"
  load_parent_dependencies "$dependency_or_parent_path"
}

function load_required_dependency() {
  local dependency_or_parent_path="$1"
  local dependency_name="$2"
  local dependency_dir="$PACKAGE_INSTALLER_PATH/$dependency_or_parent_path/$dependency_name"
  echo "dependency_dir=$dependency_dir"
  if [ ! -d "$dependency_dir" ]; then
    echo "ERROR: $dependency_dir is not found in required dependencies."
    exit 1
  fi
  source "$dependency_dir/src/main.sh"
}

function load_required_dependencies() {
  local dependency_or_parent_path="$1"
  local required_dependencies=("bash-log")
  # Iterate through dependencies and check if they exist and load them.
  for required_dependency in "${required_dependencies[@]}"; do
    load_required_dependency "$dependency_or_parent_path" "$required_dependency"
  done
}

function load_parent_dependencies() {
  local dependency_or_parent_path="$1"
  local parent_dependencies=("bash-create-onion-domains" "bash-ssh-over-tor" "bash-start-tor-at-boot")
  # Iterate through dependencies and check if they exist and load them.
  for parent_dep in "${parent_dependencies[@]}"; do
    local parent_dep_dir="$PACKAGE_INSTALLER_PATH/../$parent_dep"
    echo "parent_dep_dir=$parent_dep_dir"
    # Check if the parent repo above the dependency dir is the parent dependency.
    if [ ! -d "$PACKAGE_INSTALLER_PATH/../$parent_dep" ]; then
      # Must load the dependency as any other fellow dependency if it is not
      # a parent dependency.
      load_required_dependency "$dependency_or_parent_path" "$required_dependency"
    else
      # Load the parent dependency.
      # shellcheck disable=SC1090
      source "$PACKAGE_INSTALLER_PATH/../$parent_dep/src/main.sh"
    fi

  done
}

load_dependencies
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
