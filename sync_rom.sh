#!/bin/bash

set -exv

# sync rom
repo init -u git://github.com/LineageOS/android.git -b lineage-18.1 --depth=1
git clone https://github.com/LinkBoi00/linkmanifest -b eleven --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
