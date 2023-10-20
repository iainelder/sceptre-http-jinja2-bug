#!/bin/env bash

set -euxo pipefail

export PYTHONWARNINGS=ignore

env --chdir=test/templates python3 -m http.server --bind "127.0.0.1" &
http_pid=$!

env --chdir=test sceptre --output=yaml generate file/test.yaml

env --chdir=test sceptre --output=yaml generate http/test.yaml

kill "$http_pid"
