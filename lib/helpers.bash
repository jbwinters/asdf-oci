#!/usr/bin/env bash

set -euo pipefail

function construct_release_object() {
	local install_version="${1}"
	local os_name="${2}"

	echo "oci-cli-${install_version}-${os_name}-Offline.zip"
}
