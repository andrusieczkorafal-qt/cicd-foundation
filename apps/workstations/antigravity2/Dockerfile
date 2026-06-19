# syntax=docker/dockerfile:1.4

# Copyright 2026 Google LLC
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

# This image layers the Antigravity 2.0 application onto the GNOME foundation.

# The BASE_IMAGE is resolved by Skaffold.
ARG BASE_IMAGE

FROM ${BASE_IMAGE}
ARG DEBIAN_FRONTEND=noninteractive
ARG ANTIGRAVITY2_VERSION=2.1.4-6481382726303744
ARG ANTIGRAVITY2_SHA256=4ffb032a0410d22fe50cbdf66d72f5bd78bebef058229dc0524b4bdf069a659a
ARG CURL_OPTS="-fsSL --retry 3 --connect-timeout 10 --max-time 300"

ENV ANTIGRAVITY2_VERSION=${ANTIGRAVITY2_VERSION}
ENV ANTIGRAVITY2_SHA256=${ANTIGRAVITY2_SHA256}
ENV WORKSTATION_DEFAULT_APP="antigravity"
ENV APP_STARTUP_DELAY=5

# Merge assets into the container
COPY assets/ /

# Perform centralized workstation configuration (hooks, packages, and integration).
RUN /google/scripts/build/configure_workstation.sh
