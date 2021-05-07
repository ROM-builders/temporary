#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch aosp_mido-user
#m aex -j$(nproc --all)
make clean
make bootimage
