#!/bin/bash

# Copyright (C) 2026 The Qt Company Ltd.
# All rights reserved.
#
# This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
# WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

set -euo pipefail

source "/google/scripts/common.sh"
source "/google/scripts/fetch_assets.sh"

# Define variables
CURL_OPTS="${CURL_OPTS}"
SQUISH_DOWNLOAD_URL="${SQUISH_DOWNLOAD_URL}"
SQUISH_GCP_LICENSE_SECRET="${SQUISH_GCP_LICENSE_SECRET}"
SQUISH_LICENSE_KEY="${SQUISH_LICENSE_KEY}"
SQUISH_SHA256="${SQUISH_SHA256}"

_INSTALLER_NAME="squish-android-linux64.run"
_LICENSE_KEY_PATH="/tmp/squish-license-key"
_QT_DIR="/opt/qt"
_SQUISH_LICENSE=".squish-license"
_SQUISH_TARGET_DIR="${_QT_DIR}/squish"


fetch_installer() {
  log "Fetching Squish installer..."
  download_and_validate "${SQUISH_DOWNLOAD_URL}" "${SQUISH_SHA256}" "${_INSTALLER_NAME}"
  chmod +x "${_INSTALLER_NAME}"
}


fetch_license_key() {
  if [[ -n "${SQUISH_LICENSE_KEY}" ]]; then
    log "Fetching license from SQUISH_LICENSE_KEY variable..."
    printf \
      "%s" \
      "${SQUISH_LICENSE_KEY}" \
    > "${_LICENSE_KEY_PATH}"
    return 0
  fi

  if [[ -n "${SQUISH_GCP_LICENSE_SECRET}" ]]; then
    log "Fetching license key from GCP Secret Manager (secret: ${SQUISH_GCP_LICENSE_SECRET})..."
    gcloud \
      secrets \
      versions \
      access \
      latest \
      --secret=${SQUISH_GCP_LICENSE_SECRET} \
      > "${_LICENSE_KEY_PATH}"
    return 0
  fi
}


install() {
  log "Running Squish installer..."
  mkdir -p "${_SQUISH_TARGET_DIR}"
  ./${_INSTALLER_NAME} \
      unattended=1 \
      targetdir="${_SQUISH_TARGET_DIR}" \
      licensekey="$(cat ${_LICENSE_KEY_PATH})"
  mv "${HOME}/${_SQUISH_LICENSE}" "${_QT_DIR}"
}


cleanup() {
  log "Removing license key..."
  rm "${_LICENSE_KEY_PATH}"
  rm "${_INSTALLER_NAME}"
}


main() {
  log "Begin Squish installation..."
  fetch_installer
  fetch_license_key
  install
  cleanup
}


if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
