#!/bin/bash

# build rom
source build/envsetup.sh
lunch aosp_ysl-user
make bacon
