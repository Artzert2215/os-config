#!/bin/bash
set -eu

if ! ping -q -W 1 -i 1 -c 1 github.com; then
	echo "No internet or github.com unreachable. Bailing out now."
	exit 1
fi

REPOSITORY_ROOT=/var/lib/coderdojo-deploy

set -x

cd "${REPOSITORY_ROOT}"
git pull
librarian-puppet update --verbose

puppet apply "${REPOSITORY_ROOT}/manifests/site.pp"
