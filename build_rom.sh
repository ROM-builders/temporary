#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch lineage_mojito-user
export SKIP_API_CHECKS=true
mka bacon

