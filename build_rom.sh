#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch lineage_mojito-userdebug
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true 
mka bacon -j10