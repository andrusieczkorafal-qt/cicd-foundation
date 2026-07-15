#!/bin/bash

# Copyright (C) 2026 The Qt Company Ltd.
# All rights reserved.
#
# This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
# WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

set -euo pipefail

source "/google/scripts/common.sh"

_QT_DIR="/opt/qt"
_SQUISH_DIR="${_QT_DIR}/squish"
_SQUISH_LICENSE=".squish-license"
_SQUISH_LICENSE_PATH="${_QT_DIR}/${_SQUISH_LICENSE}"

squish_make_symlink() {
    ln -s "${_SQUISH_DIR}" "/home/${WORKSTATION_USER}"
    ln -s "${_SQUISH_LICENSE_PATH}" "/home/${WORKSTATION_USER}"
}

main() {
  echo "Setting Squish..."
  squish_make_symlink
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
