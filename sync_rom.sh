#!/bin/bash

set -exv

# sync rom
repo init --depth=1 -u git://github.com/ForkLineageOS/android.git -b lineage-18.1
git clone https://github.com/Realme-G70-Series/local_manifest.git -b 11-staging --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)


