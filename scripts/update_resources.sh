#!/bin/sh

providers=$(cat resources.yaml | yq -r '.providers[].name')

selected_provider=$(echo "$providers" | fzf --prompt="Select provider: ")

ansible-playbook -i "localhost," update_resources.yaml -e "target_provider_name=$selected_provider" --vault-id demo@vault