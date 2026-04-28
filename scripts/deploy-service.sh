#!/bin/bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <folder_name>"
  exit 1
fi

FOLDER_NAME="$1"
BASE_DIR="/var/docker/compose"
SERVICE_DIR="${BASE_DIR}/${FOLDER_NAME}"

if [[ ! -d "${SERVICE_DIR}" ]]; then
  echo "Error: Folder '${SERVICE_DIR}' does not exist."
  exit 1
fi

# Find the first .yml or .yaml file in the folder
SERVICE_FILE=$(find "${SERVICE_DIR}" -maxdepth 1 -type f \( -name "*.yml" -o -name "*.yaml" \) | head -n 1)

if [[ -z "${SERVICE_FILE}" ]]; then
  echo "Error: No .yml or .yaml file found in '${SERVICE_DIR}'."
  exit 1
fi

STACK_NAME=itt

echo "Deploying Docker Stack '${STACK_NAME}' using service file: ${SERVICE_FILE}..."
docker stack deploy -c "${SERVICE_FILE}" "${STACK_NAME}"

echo "Docker Stack '${STACK_NAME}' deployed successfully."