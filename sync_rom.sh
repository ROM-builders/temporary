#!/bin/bash

set -exv

# Sync rom
repo init -u git://github.com/AospExtended/manifest.git -b 11.x --depth=1
git clone https://github.com/jrchintu/android_.repo_local_manifests.git --depth=1 -b debloat .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j"$(nproc --all)"
