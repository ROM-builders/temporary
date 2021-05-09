#!/bin/bash

# Build the ROM
source build/envsetup.sh
lunch lineage_daisy-userdebug
make installclean
mka bacon


