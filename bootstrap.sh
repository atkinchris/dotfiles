#!/bin/bash
set -eu

cd "$(dirname "${BASH_SOURCE}")"

function doIt() {
	rsync \
		--exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "*.sh" \
		--exclude "README.md" \
		--exclude "Makefile" \
		-avh \
		--no-perms \
		. ~
	source ~/.bash_profile
}

doIt
unset doIt
