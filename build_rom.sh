#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch lineage_RMX2020-userdebug
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
mka api-stubs-docs
mka system-api-stubs-docs
mka test-api-stubs-docs
mka bacon -j8
