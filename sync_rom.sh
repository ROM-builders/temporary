#!/bin/bash

set -exv

# sync rom
repo init -u git://github.com/crdroidandroid/android.git --depth=1 -b 11.0
git clone https://github.com/boedhack/local_manifest.git -b 11.0 --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

cd /tmp/rom
