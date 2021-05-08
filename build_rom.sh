#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
export CIPHER_OFFICIAL=true
lunch lineage_ysl-user
make bacon
