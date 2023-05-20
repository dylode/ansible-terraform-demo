#!/bin/sh

set -e

providers=$(cat resources.yaml | yq -r '.providers[].name')

selected_provider=$(echo "$providers" | fzf --prompt="Select provider: ")
echo "Selected provider: $selected_provider"

destroy_mode=false
read -r -p "Do you expect to delete resources? [y/N] " response
if [[ "$response" == "yes" || "$response" == "y" ]]; then
    destroy_mode=true
fi

read -r -p "Are you sure you want to proceed? [y/N] " response
if [[ "$response" != "yes" && "$response" != "y" ]]; then
    exit 1
fi


ansible-playbook -i "localhost," update_resources.yaml -e "target_provider_name=$selected_provider" -e "destroy_mode=$destroy_mode" --vault-id demo@vault
ansible-playbook -i terraform/$selected_provider/inventory.yaml "$@" wait_hosts_up.yaml -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" -e "ansible_python_interpreter=/usr/local/bin/python3"
ansible-playbook -i terraform/$selected_provider/inventory.yaml "$@" site.yaml -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"
