#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source ./constants.sh

docker push "${PAINLESS_INFRA_IMAGE}"
