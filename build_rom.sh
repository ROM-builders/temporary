#!/bin/bash

set -exv

source build/envsetup.sh
lunch aosp_ysl-userdebug
make bacon
