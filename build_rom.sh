#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch derp_vayu-userdebug
mka derp
