#!/bin/bash

set -e
set -x

# sync rom
repo init --depth=1 -u https://github.com/ArrowOS/android_manifest.git -b arrow-11.0
git clone https://github.com/P-Salik/local_manifest --depth=11 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# patches

# boot

cd external/selinux
wget https://github.com/PixelExperience/external_selinux/commit/9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc.patch
patch -p1 < *.patch
cd ../..

# ims

cd frameworks/base
wget https://github.com/PixelExperience/frameworks_base/commit/37f5a323245b0fd6269752742a2eb7aa3cae24a7.patch
patch -p1 < *.patch
cd ../..

cd frameworks/opt/net/wifi
wget https://github.com/PixelExperience/frameworks_opt_net_wifi/commit/3bd2c14fbda9c079a4dc39ff4601ba54da589609.patch
patch -p1 < *.patch
cd ../../../..

cd frameworks/opt/net/ims
wget https://github.com/PixelExperience/frameworks_opt_net_ims/commit/661ae9749b5ea7959aa913f2264dc5e170c63a0a.patch
patch -p1 < *.patch
cd ../../../../

# build rom
. build/envsetup.sh
lunch arrow_RMX1941-eng
chmod -R 755 out/
m bacon

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/RMX1941/*.zip
