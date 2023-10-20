#!/bin/env bash

set -euo pipefail

export PYTHONWARNINGS=ignore

env --chdir=test/templates python3 -m http.server --bind "127.0.0.1" &> /dev/null &

find test/config -type f ! -name config.yaml -printf '%P\0' \
| sort -z \
| xargs -t -0 -n1 env --chdir=test sceptre --output=yaml generate

pkill -f http.server
