#!/bin/bash

set -exv

# Sync Everything
repo init -u --depth=1 https://github.com/arulebin/android_manifest.git -b eleven
git clone https://github.com/arulebin/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
