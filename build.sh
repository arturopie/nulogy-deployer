#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source ./constants.sh

docker build -t "${PAINLESS_INFRA_IMAGE}" src
