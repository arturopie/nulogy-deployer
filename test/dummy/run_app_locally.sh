#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source constants.sh
docker run --rm -it -p 3000:80 "${DUMMY_APP}"
