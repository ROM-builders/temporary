#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch styx_j4primelte-userdebug
m styx-ota
