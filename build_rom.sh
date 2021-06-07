#!/bin/bash

set -e
set -x

# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/descendant-xi/manifests.git -b eleven-staging -g default,-device,-mips,-darwin,-notdefault -b eleven-staging -g default,-device,-mips,-darwin,-notdefault 
 
git clone https://github.com/mukulsharma05175/frostmanifest.git --depth=1 -b derp .repo/local_manifests 

repo sync --force-sync --no-tags --no-clone-bundle -j$(nproc --all)
 


# build rom
source build/envsetup.sh
lunch descendant_lavender-userdebug
make bacon

# upload rom
up(){
  curl --upload-file $1 https://transfer.sh/$(basename $1); echo
  # 14 days, 10 GB limit
}

up out/target/product/lavender/*.zip
