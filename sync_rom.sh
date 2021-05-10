#!/bin/bash

set -exv

# Sync Everything
repo init --depth=1 -u https://github.com/arulebin/android_manifest.git -b eleven
git clone https://github.com/arulebin/local_manifest.git -b cph .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

