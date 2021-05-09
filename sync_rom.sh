#!/bin/bash

set -exv

# sync rom
repo init -u https://github.com/StyxProject/manifest.git --depth=1 -b R
git clone https://github.com/nnippon/local_buildbot.git --depth=1 -b fluid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
echo finished sync

# Fix errors
rm -rf hardware/ril/libril vendor/qcom/opensource/power && git clone https://github.com/nnippon/android_vendor_qcom_opensource_power -b 11 vendor/qcom/opensource/power
