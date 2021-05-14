#!/bin/bash

set -e
set -x

sudo apt install wget -y

rm -rf .repo/local_manifest

# sync rom
repo init -u https://github.com/PixelExperience/manifest -b eleven -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/cArN4gEisDeD/local_manifest

repo sync -c -j8 --force-sync --no-clone-bundle --no-tags

# patches
cd /external/selinux git fetch https://github.com/PixelExperience/external_selinux && git cherry-pick 9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc
cd ../..
cd /frameworks/base git fetch https://github.com/PixelExperience/frameworks_base && git cherry-pick 37f5a323245b0fd6269752742a2eb7aa3cae24a7
cd ../..
cd /frameworks/opt/net/wifi git fetch https://github.com/PixelExperience/frameworks_opt_net_wifi && git cherry-pick 3bd2c14fbda9c079a4dc39ff4601ba54da589609
cd ../../../..
cd /frameworks/opt/net/ims git fetch https://github.com/PixelExperience/frameworks_opt_net && git cherry-pick 661ae9749b5ea7959aa913f2264dc5e170c63a0a
cd ../../../..

# build rom
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
mka bacon -j8

# upload rom
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
