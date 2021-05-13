#!/bin/bash

set -exv

# sync rom
repo init -u  git://github.com/AOSiP/platform_manifest.git -b eleven --depth=1 -g default,-device,-mips,-darwin,-notdefault
git clone  https://github.com/flashokiller/mainfest_personal --depth=1  .repo/local_manifests -b master
repo sync --force-sync --no-tags --no-clone-bundle
ls
#build
echo="ok!"
source build/envsetup.sh
lunch aosip_ysl-userdebug
time m kronic

# upload rom
rclone copy out/target/product/ysl/Aosip*.zip
