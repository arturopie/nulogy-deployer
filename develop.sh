#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source ./constants.sh
source ./test/dummy/constants.sh

docker run -it --rm \
  --env APP_IMAGE_SOURCE="${DUMMY_APP}" \
  --volume ~/.aws/:/root/.aws \
  --volume "$(pwd)"/src:/painless-infra \
  --volume "$(pwd)"/test/dummy:/dummy \
  --workdir /dummy \
  "${PAINLESS_INFRA_IMAGE}" \
  /bin/bash
