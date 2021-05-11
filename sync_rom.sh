#!/bin/bash

set -exv

# sync rom
repo init --depth=1 -u git://github.com/LineageOS/android.git -b lineage-18.1
git clone https://github.com/sarthakroy2002/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)


