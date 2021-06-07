#!/bin/bash

set -e
set -x

# sync rom
repo init -u https://github.com/descendant-xi/manifests.git -b eleven-staging
 
https://github.com/mukulsharma05175/frostmanifest.git --depth=1 -b derp .repo/local_manifests 

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)


# build rom
source build/envsetup.sh
lunch octavi_lavender-userdebug
make bacon

# upload rom
up(){
  curl --upload-file $1 https://transfer.sh/$(basename $1); echo
  # 14 days, 10 GB limit
}

up out/target/product/lavender/*.zip
