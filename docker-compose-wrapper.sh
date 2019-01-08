#!/bin/bash
set -eu -o pipefail

if [[ -e .env ]]; then
  # shellcheck disable=SC1091
  . .env
fi

[[ -n "${AUTH_USERNAME:-}" ]] || { echo "AUTH_USERNAME is not defined."; exit 1; }
[[ -n "${AUTH_PASSWORD:-}" ]] || { echo "AUTH_PASSWORD is not defined."; exit 1; }
[[ -n "${REGISTRY_HOST:-}" ]] || { echo "REGISTRY_HOST is not defined."; exit 1; }

docker-compose "$@"
