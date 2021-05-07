#!/bin/bash

set -exv

#sync rom
repo init -u git://github.com/DerpFest-11/manifest.git -b 11 --depth=1
git clone https://github.com/pocox3pro/Local-Manifests --depth=1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

#Setup
rm -rf device/generic/opengl-transport
