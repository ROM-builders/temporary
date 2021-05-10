#!/bin/bash

set -exv

# sync rom build no. 2
repo init -u git://github.com/crdroidandroid/android.git --depth=1 -b 11.0
git clone https://github.com/boedhack/local_manifest.git -b 11.0 --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

#Setup
curl https://gist.githubusercontent.com/rahul9999xda/a1859ad15991c027832b36b33d27828b/raw/0cb97e3074a2b0260ecdbc8c7a64bb5b45d4834e/gms_full.mk >> gms_full.mk
mv gms_full.mk vendor/gms/
rm -rf device/generic/opengl-transport

