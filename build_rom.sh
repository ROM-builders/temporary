#!/bin/bash

set -exv

# Build PE
echo -e "Be ready to build PE"
. build/envsetup.sh
lunch aosp_ysl-userdebug
make bacon
