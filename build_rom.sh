#!/bin/bash

set -exv

# building rom
source build/envsetup.sh
lunch aosp_RMX1941-userdebug
mka bacon -j8
