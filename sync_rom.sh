#!/bin/bash

set -exv

#sync rom
repo init --depth=1 -u https://github.com/Wave-Project/manifest -b r
git clone https://github.com/Apon77Lab/android_.repo_local_manifests.git --depth 1 -b aex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
