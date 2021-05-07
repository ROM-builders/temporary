#!/bin/bash

set -exv

#build rom
. build/envsetup.sh
lunch aosip_ysl-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export WITH_GAPPS=true
time m kronic -j$(nproc --all)
