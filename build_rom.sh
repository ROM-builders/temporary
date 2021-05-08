#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch lineage_ysl-user
make bacon
