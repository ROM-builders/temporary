#!/bin/bash

set -exv
lsblk
. build/envsetup.sh
lunch aosip_ysl-userdebug
time m kronic
