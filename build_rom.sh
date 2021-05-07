#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch aosp_mido-user
make clean
m aex -j$(nproc --all)
