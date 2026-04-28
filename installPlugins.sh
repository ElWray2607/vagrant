#!/bin/bash

input_file="plugins"

while IFS= read -r plugin || [[ -n "$plugin" ]]; do
  echo "Installing plugin: $plugin"
  vagrant plugin install "$plugin"
done < "$input_file"