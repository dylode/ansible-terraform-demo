#!/bin/bash

providers=$(cat resources.yaml | yq -r '.providers[].name')

selected_provider=$(echo "$providers" | fzf --prompt="Select provider: ")
echo "Selected provider: $selected_provider"


read -r -p "Are you sure you want to proceed? [y/N] " response
if [[ "$response" != "yes" && "$response" != "y" ]]; then
    exit 1
fi

ansible-playbook -i terraform/$selected_provider/inventory.yaml $@ site.yaml -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"
