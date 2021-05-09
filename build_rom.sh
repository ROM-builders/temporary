#!/bin/bash

set -exv

# Run Build
source build/envsetup.sh
export CIPHER_OFFICIAL=true
lunch lineage_rosy-userdebug
make bacon -j$(nproc --all)
