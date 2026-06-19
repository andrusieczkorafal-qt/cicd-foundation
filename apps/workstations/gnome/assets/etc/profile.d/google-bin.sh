#!/bin/bash
# Add /google/bin to PATH for interactive shells.
if [[ ":$PATH:" != *":/google/bin:"* ]]; then
  PATH="${PATH}:/google/bin"
fi