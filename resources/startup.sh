#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

echo "### Container restarts ###"

"${STARTUP_DIR}/silly-dogu"