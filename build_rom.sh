#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch evolution_mido-user
mka bacon

