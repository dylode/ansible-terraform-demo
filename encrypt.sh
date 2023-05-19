#!/bin/bash

find ./terraform/ -type f \( -name "*.tfstate" -o -name "*.tfstate.backup" -o -name "provider.tf" \) | while read -r path; do
    ansible-vault encrypt --vault-id demo@vault $path 
done