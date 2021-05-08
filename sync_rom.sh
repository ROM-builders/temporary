#!/bin/bash

set -exv

# sync rom
repo init --depth=1 -u https://github.com/PixelExperience/manifest -b eleven

git clone https://github.com/DhruvChhura/mainfest_personal.git --depth=1 -b pe .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)


