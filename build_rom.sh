#!/bin/bash

set -exv

# Build the ROM
source build/envsetup.sh
lunch lineage_daisy-userdebug
mka bacon -j16


