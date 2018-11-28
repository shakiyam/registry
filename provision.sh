#!/bin/bash
set -eu -o pipefail

certs_dir="$(cd "$(dirname "$0")" && pwd)/certs"

mkdir -p . "$certs_dir"

openssl req -newkey rsa:2048 -nodes -sha256 -keyout "$certs_dir"/ca.key -x509 -days 3650 -out "$certs_dir"/ca.crt <<EOT





$(hostname)

EOT
