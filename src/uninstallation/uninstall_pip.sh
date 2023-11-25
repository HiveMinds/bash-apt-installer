#!/usr/bin/env bash

pip_remove() {
  local pip_package_name="$1"

  yellow_msg "Removing ${pip_package_name} if it is installed."

  pip remove "$pip_package_name" -y >>/dev/null 2>&1

  verify_pip_removed "$pip_package_name"
}

apt_package_is_installed() {
  local pip_package_name="$1"

  # Get the number of packages installed that match $1
  local num
  num=$(dpkg -l "$pip_package_name" 2>/dev/null | grep -c -E '^ii')

  if [ "$num" -eq 1 ]; then
    echo "FOUND"
  elif [ "$num" -gt 1 ]; then
    echo "More than one match"
    exit 1
  else
    echo "NOTFOUND"
  fi
}

# Verifies pip package is installed.
verify_pip_removed() {
  local pip_package_name="$1"

  # Determine if pip package is installed or not.
  local pip_pckg_exists
  pip_pckg_exists=$(
    pip list | grep -F "$pip_package_name"
    echo $?
  )

  # Throw error if pip package is not yet installed.
  if [ "$pip_pckg_exists" == "1" ]; then
    green_msg "Verified pip package ${pip_package_name} is removed."

  else
    red_msg "Error, the pip package ${pip_package_name} is still installed."
    exit 3 # TODO: update exit status.
  fi
}
