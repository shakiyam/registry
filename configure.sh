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

auth_dir="$(cd "$(dirname "$0")" && pwd)/auth"
mkdir -p "$auth_dir"
docker run \
  --rm \
  --entrypoint htpasswd \
  registry:2 \
  -nb -B "$AUTH_USERNAME" "$AUTH_PASSWORD" > "$auth_dir"/htpasswd

certs_dir="$(cd "$(dirname "$0")" && pwd)/certs"
mkdir -p "$certs_dir"
openssl req -newkey rsa:2048 -nodes -sha256 -keyout "$certs_dir"/ca.key -x509 -days 3650 -out "$certs_dir"/ca.crt <<EOT
.
.
.
.
.
$(hostname)
.
EOT
