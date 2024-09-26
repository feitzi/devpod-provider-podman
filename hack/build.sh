#!/usr/bin/env bash
set -e

PROVIDER_ROOT=$(git rev-parse --show-toplevel)
COMMIT_HASH=$(git rev-parse --short HEAD 2>/dev/null)
DATE=$(date "+%Y-%m-%d")
BUILD_PLATFORM=$(uname -a | awk '{print tolower($1);}')

echo "Current working directory is $(pwd)"
echo "PATH is $PATH"

if [[ "$(pwd)" != "${PROVIDER_ROOT}" ]]; then
  echo "you are not in the root of the repo" 1>&2
  echo "please cd to ${PROVIDER_ROOT} before running this script" 1>&2
  exit 1
fi

if [[ -z "${PROVIDER_BUILD_PLATFORMS}" ]]; then
    PROVIDER_BUILD_PLATFORMS="linux windows darwin"
fi

if [[ -z "${PROVIDER_BUILD_ARCHS}" ]]; then
    PROVIDER_BUILD_ARCHS="amd64 arm64"
fi

# Create the release directory
mkdir -p "${PROVIDER_ROOT}/release"

# generate provider.yaml
cp hack/provider/provider.yml "${PROVIDER_ROOT}/release/provider.yaml"
