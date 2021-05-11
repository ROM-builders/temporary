#!/bin/bash

set -exv

# sync rom
repo init -u https://github.com/PixelExperience/manifest --depth=1 -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/P-Salik/local_manifest --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
