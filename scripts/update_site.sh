#!/bin/bash

providers=$(cat resources.yaml | yq -r '.providers[].name')

selected_provider=$(echo "$providers" | fzf --prompt="Select provider: ")

ansible-playbook -i terraform/$selected_provider/inventory.yaml $@ site.yaml -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"