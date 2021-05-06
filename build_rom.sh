#!/bin/bash

set -ex

# build rom
source build/envsetup.sh
lunch aosp_mido-user
m aex -j$(nproc --all)
