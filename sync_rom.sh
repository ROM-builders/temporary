#!/bin/bash

set -exv

# sync rom
repo init -u git://github.com/Evolution-X/manifest -b elle --depth=1
git clone https://github.com/AhmedElwakil2004/local_manifest_test.git -b main --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
