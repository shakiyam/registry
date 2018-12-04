#!/bin/bash
set -eu -o pipefail

if [[ -e .env ]]; then
  # shellcheck disable=SC1091
  . .env
fi

if [[ -z "${AUTH_USERNAME:-}" || -z "${AUTH_PASSWORD:-}" ]]; then
  echo "AUTH_USERNAME or AUTH_PASSWORD is not defined."
  exit 1
fi

docker-compose "$@"
