#!/bin/bash

set -exv

# sync rom
repo init -u git://github.com/ForkLineageOS/android.git --depth=1 -b lineage-18.1
git clone https://github.com/Realme-G70-Series/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
