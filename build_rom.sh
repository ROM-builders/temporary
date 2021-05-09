#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch lineage_mojito-userdebug
export SKIP_ABI_CHECKS=true 
export SKIP_API_CHECKS=true
mka bacon -j64
