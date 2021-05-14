#!/bin/bash

set -e
set -x

sudo apt install wget -y

rm -rf .repo/local_manifest

# sync rom
repo init -u https://github.com/Palladium-OS/platform_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/cArN4gEisDeD/local_manifest

repo sync -c -q --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# build
. build/env*
lunch palladium_RMX1941-userdebug
mka palladium -j$(nproc --all)

# upload rom
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
