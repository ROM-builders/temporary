#!/bin/bash

# Build the ROM
source build/envsetup.sh
lunch lineage_daisy-user
mka clean
mka bacon


