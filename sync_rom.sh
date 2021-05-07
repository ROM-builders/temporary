#!/bin/bash

set -exv

# sync rom
repo init -u https://github.com/P-404/platform_manifest -b rippa --depth=1
git clone https://github.com/Project404-whyred/local_manifests.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
