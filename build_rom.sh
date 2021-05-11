#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch lineage_daisy-userdebug
mka bacon

