#!/bin/bash

set -exv

# building rom
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
mka bacon
