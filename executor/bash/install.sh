#!/usr/bin/env bash

# Every modern linux should have python installed by default.
if ! carburator fn integration-installed python3; then
  carburator print terminal error \
    "Missing required program python. Please install it before proceeding."
  exit 110
fi

if ! carburator fn integration-installed pip; then
  carburator print terminal warn \
    "Missing python package manager pip, trying install..."

  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py --user
  
  rm -f get-pip.py
fi

if ! carburator fn integration-installed ansible; then
  carburator print terminal warn \
    "Missing required program Ansible. Trying install...."
    
  python3 -m pip install --user ansible
fi

# ansible-runner is required for extracting runtime information from playbooks
if ! carburator fn integration-installed ansible-runner; then
  carburator print terminal warn \
    "Missing required program ansible-runner. Trying install..."
    
  python3 -m pip install --user ansible-runner
fi

# # python library netaddr is required for ansible.netcommon collection
# if ! carburator fn integration-installed "pip show netaddr"; then
#   carburator print terminal error "Missing required python library netaddr. Please install it" \
#     "before proceeding." && exit 110
# fi

# # Ansible galaxy is required.
# if ! carburator fn integration-installed ansible-galaxy; then
#   carburator print terminal error "Missing required program ansible-galaxy. Please install it" \
#     "before running this script."
# fi

# ###
# # Install required ansible collections / roles.
# #
# carburator print terminal attention "Installing required ansible collections..."

# # Install ansible role for authorizing ssh keys
# ansible-galaxy collection install ansible.posix

# # Install community general for just about everything.
# ansible-galaxy collection install community.general

# # Install ansible role for extracting and manipulating network information.
# ansible-galaxy collection install ansible.netcommon
