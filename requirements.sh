#!/bin/bash

# Ansible is required.
if ! carburator fn integration-installed ansible; then
  carburator fn echo error "Missing required program Ansible. Please install it" \
    "before running this script."
  carburator fn echo info "You most likely don't have ansible-runner either," \
    "register that too while at it" && exit 1
fi

# ansible-runner is required for extracting runtime information from playbooks
if ! carburator fn integration-installed ansible-runner; then
  carburator fn echo error "Missing required program ansible-runner. Please install it" \
    "before proceeding." && exit 1
fi

# python package manager is required for everything
if ! carburator fn integration-installed pip; then
  carburator fn echo error "Missing required program pip. Please install it" \
    "before proceeding." && exit 1
fi

# python library netaddr is required for ansible.netcommon collection
if ! carburator fn integration-installed "pip show netaddr"; then
  carburator fn echo error "Missing required python library netaddr. Please install it" \
    "before proceeding." && exit 1
fi

# Ansible galaxy is required.
if ! carburator fn integration-installed ansible-galaxy; then
  carburator fn echo error "Missing required program ansible-galaxy. Please install it" \
    "before running this script."
fi

###
# Install required ansible collections / roles.
#
carburator fn echo attention "Installing required ansible collections..."

# Install ansible role for authorizing ssh keys
ansible-galaxy collection install ansible.posix

# Install community general for just about everything.
ansible-galaxy collection install community.general

# Install ansible role for extracting and manipulating network information.
ansible-galaxy collection install ansible.netcommon
