#!/bin/bash

df -h 

## sync rom
repo init -u https://github.com/Project-Fluid/manifest.git --depth=1 -b fluid-11
git clone https://github.com/adrian-8901/local_mainfest.git --depth=1 -b fluid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
ls 
echo finished sync
. build/envsetup.sh
lunch fluid_umi-userdebug
mka bacon -j$(nproc --all)
ccache -s
up() {
      curl --upload-file $1 https://transfer.sh/$(basename $1); echo
      # 14 days, 10 GB limit
    }

up out/target/product/umi/*.zip

# 1