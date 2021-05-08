#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch fluid_j4primelte-userdebug
mka bacon -j$(nproc --all)
