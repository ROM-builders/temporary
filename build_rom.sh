#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch fluid_umi-userdebug
mka bacon -j64
