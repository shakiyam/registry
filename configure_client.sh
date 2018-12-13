#!/bin/bash
set -eu -o pipefail

if [[ -e .env ]]; then
  # shellcheck disable=SC1091
  . .env
fi

[[ -n "${AUTH_USERNAME:-}" ]] || { echo "AUTH_USERNAME is not defined."; exit 1; }
[[ -n "${AUTH_PASSWORD:-}" ]] || { echo "AUTH_PASSWORD is not defined."; exit 1; }
[[ -n "${REGISTRY_HOST:-}" ]] || { echo "REGISTRY_HOST is not defined."; exit 1; }
[[ -n "${REGISTRY_OWNER:-}" ]] || { echo "REGISTRY_OWNER is not defined."; exit 1; }
[[ -n "${REGISTRY_HOME:-}" ]] || { echo "REGISTRY_HOME is not defined."; exit 1; }

sudo scp "${REGISTRY_OWNER}@${REGISTRY_HOST}:${REGISTRY_HOME}/certs/ca.crt" "/etc/pki/ca-trust/source/anchors/${REGISTRY_HOST}.crt"
sudo update-ca-trust
sudo systemctl restart docker
docker login "${REGISTRY_HOST}" -p "${AUTH_PASSWORD}" -u "${AUTH_USERNAME}"
