#!/bin/bash

# Build the ROM
source build/envsetup.sh
lunch lineage_daisy-user
make installclean
mka bacon


