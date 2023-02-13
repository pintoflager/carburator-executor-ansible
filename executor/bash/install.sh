#!/usr/bin/env bash

role="$1"

# Every modern linux should have python installed by default.
if ! carburator has program python3; then
  carburator print terminal error \
    "Missing required program python. Please install it before proceeding."
  exit 120
fi

# Package installation tasks on a local client node. Runs first
#
#
if [ "$role" = 'client' ]; then
    carburator print terminal info "Executing ansible install script on $role"

    if ! carburator has program pip || ! carburator has program ansible ||
    ! carburator has program ansible-runner; then
        carburator print terminal warn \
            "Missing ansible / dependencies on local client machine."

        carburator prompt yes-no \
            "Should we try to install dependencies? Installs on your PC." \
            --yes-val "Yes try to install with a script" \
            --no-val "No, I'll install everything"; exitcode=$?

        if [[ $exitcode -ne 0 ]]; then
          exit 120
        fi
    fi
fi

if ! carburator has program pip; then
  carburator print terminal warn \
    "Missing python package manager pip, trying install..."

  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py --user
  
  rm -f get-pip.py
fi

if ! carburator has program ansible; then
  carburator print terminal warn \
    "Missing required program Ansible. Trying install...."
    
  python3 -m pip install --user ansible
fi

# ansible-runner is required for extracting runtime information from playbooks
if ! carburator has program ansible-runner; then
  carburator print terminal warn \
    "Missing required program ansible-runner. Trying install..."
    
  python3 -m pip install --user ansible-runner
fi

# # python library netaddr is required for ansible.netcommon collection
# if ! carburator has program "pip show netaddr"; then
#   carburator print terminal error "Missing required python library netaddr. Please install it" \
#     "before proceeding." && exit 120
# fi

# # Ansible galaxy is required.
# if ! carburator has program ansible-galaxy; then
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
