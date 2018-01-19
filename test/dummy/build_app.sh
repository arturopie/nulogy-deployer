#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source constants.sh
docker build -t "${DUMMY_APP}" .
