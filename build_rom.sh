#!/bin/bash

set -exv

source build/envsetup.sh
lunch cherish_begonia-userdebug
mka bacon -j$(nproc --all)
