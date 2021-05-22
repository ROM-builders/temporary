#!/bin/bash

set -exv

#Sync ROM
repo init --depth=1 -u https://github.com/Wave-Project/manifest -b r -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/yashlearnpython/local_manifest.git --depth=1 -b wave-os .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

