#!/bin/bash
set -eu

pushd "$(dirname "${BASH_SOURCE[0]}")"
# Note: directory entries in files.txt (ending with /) are copied recursively.
rsync -avr --no-perms --files-from=files.txt . ~
popd
