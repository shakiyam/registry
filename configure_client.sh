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

# shellcheck disable=SC1091
os_id=$(. /etc/os-release; echo "$ID")

case $os_id in
  ol)
    sudo scp "${REGISTRY_OWNER}@${REGISTRY_HOST}:${REGISTRY_HOME}/certs/ca.crt" "/etc/pki/ca-trust/source/anchors/${REGISTRY_HOST}.crt"
    sudo update-ca-trust
    ;;
  ubuntu)
    sudo scp "${REGISTRY_OWNER}@${REGISTRY_HOST}:${REGISTRY_HOME}/certs/ca.crt" "/usr/share/ca-certificates/${REGISTRY_HOST}.crt"
    echo "${REGISTRY_HOST}.crt" | sudo tee -a /etc/ca-certificates.conf >/dev/null
    sudo update-ca-certificates
    ;;
esac

sudo systemctl restart docker
echo "${AUTH_PASSWORD}" | docker login "${REGISTRY_HOST}" --password-stdin -u "${AUTH_USERNAME}"
