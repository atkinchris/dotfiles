#!/bin/bash
set -eu

pushd "$(dirname "${BASH_SOURCE}")"
rsync -avr --no-perms --files-from=files.txt . ~
popd
