#!/bin/bash
set -euo pipefail

source /google/scripts/fetch_assets.sh

# Define variables
ANTIGRAVITY2_VERSION="${ANTIGRAVITY2_VERSION}"
ANTIGRAVITY2_SHA256="${ANTIGRAVITY2_SHA256}"
CURL_OPTS="${CURL_OPTS}"

# Construct the download URL
DOWNLOAD_URL="https://storage.googleapis.com/antigravity-public/antigravity-hub/${ANTIGRAVITY2_VERSION}/linux-x64/Antigravity.tar.gz"
TARBALL_NAME="Antigravity.tar.gz"
EXTRACT_DIR="/opt"
BINARY_PATH="/opt/Antigravity-x64/antigravity"
INSTALL_NAME="antigravity-2.0"
ALIAS_NAME="antigravity"

download_and_validate "${DOWNLOAD_URL}" "${ANTIGRAVITY2_SHA256}" "${TARBALL_NAME}"

mkdir -p "${EXTRACT_DIR}"
tar -xzf "${TARBALL_NAME}" -C "${EXTRACT_DIR}"
rm "${TARBALL_NAME}"


