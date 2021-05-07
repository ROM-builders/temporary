#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch aosp_mido-user
ccache -z
m aex -j$(nproc --all)
ccache -s
ccache -V
which ccache
