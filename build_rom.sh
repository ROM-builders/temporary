#!/bin/bash

set -exv

# Initializing build
source build/envsetup.sh
lunch corvus_mido-userdebug

# Build Rom
make bacon -j10

