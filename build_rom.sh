#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch fluid_j6primelte-userdebug
mka bacon -j64
