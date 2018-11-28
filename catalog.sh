#!/bin/bash
set -eu -o pipefail

curl --insecure "https://$(hostname)/v2/_catalog"
