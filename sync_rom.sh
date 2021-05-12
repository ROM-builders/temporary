#!/bin/bash

set -exv

# Initializing Source
repo init --depth=1 -u https://github.com/Corvus-R/android_manifest.git -b 11

# Clone Local Manifest
git clone https://github.com/AhmedElwakil2004/local_manifest_test.git --depth 1 -b corvus .repo/local_manifests

# Sync Sources
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
