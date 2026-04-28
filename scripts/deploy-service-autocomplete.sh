#!/bin/bash

_deploy_service_autocomplete() {
    local cur_word base_dir
    cur_word="${COMP_WORDS[COMP_CWORD]}"
    base_dir="/var/docker/compose"

    # Ensure the base directory exists
    if [[ -d "$base_dir" ]]; then
        # List only directories, excluding those starting with '.'
        COMPREPLY=($(compgen -W "$(find "$base_dir" -mindepth 1 -maxdepth 1 -type d -not -name ".*" -exec basename {} \;)" -- "$cur_word"))
    else
        COMPREPLY=()
    fi
}

# Register the autocomplete function for the deploy-service command
complete -F _deploy_service_autocomplete deploy-service