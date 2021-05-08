#!/bin/bash

set -exv

#build rom
. build/envsetup.sh
lunch aosip_ysl-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
time m kronic
