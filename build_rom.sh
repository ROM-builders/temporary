#!/bin/bash

# build rom
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch aosp_ysl-user
make bacon
