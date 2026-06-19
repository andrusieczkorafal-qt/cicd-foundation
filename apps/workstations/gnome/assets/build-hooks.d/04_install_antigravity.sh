#!/bin/bash

# Copyright 2025-2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

install_antigravity() {

  if [[ "${INSTALL_ANTIGRAVITY_CLI:-true}" == "true" ]]; then
    echo "Configuring Antigravity CLI..."
    chmod +x /usr/local/bin/antigravity-cli
  else
    echo "Antigravity CLI installation skipped."
  fi


  if [[ "${INSTALL_ANTIGRAVITY_SDK:-true}" == "true" ]]; then
    echo "Installing Antigravity SDK (v${ANTIGRAVITY_SDK_VERSION})..."

    # Ensure pipx is ready (environment variables should be inherited from Dockerfile/configure_workstation.sh)


  else
    echo "Antigravity SDK installation skipped."
  fi
}

main() {
  install_antigravity
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
