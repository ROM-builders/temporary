#!/bin/bash

set -exv

# Run Build
. build/envsetup.sh
lunch styx_rosy-user
m styx-ota -j$(nproc --all)
