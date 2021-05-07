#!/bin/bash

set -exv

. build/envsetup.sh
lunch soni_begonia-userdebug
mka bacon
