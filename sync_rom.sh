#!/bin/bash

set -exv

# sync rom
repo init -u git://github.com/DerpFest-11/manifest.git -b 11 --depth=1
git clone https://github.com/pocox3pro/Local-Manifests --depth=1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

#Setup
curl https://gist.githubusercontent.com/SuperCosmicBeing/c6db35d8abfa480e183a66b71ffca563/raw/3f5f1fc6d02ae767479bda37c04ea417a229f7eb/gms_full.mk >> gms_full.mk
mv gms_full.mk vendor/gms/
rm -rf device/generic/opengl-transport

