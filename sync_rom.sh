#!/bin/bash

set -exv

# sync rom
repo init -u https://github.com/PixelExperience/manifest -b eleven --depth=1
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

#device
git clone https://github.com/P-Salik/android_device_realme_RMX1941 device/realme/RMX1941 --depth 1
git clone https://github.com/P-Salik/android_vendor_realme_RMX1941 vendor/realme/RMX1941 --depth 1
cd external/selinux
git fetch https://github.com/PixelExperience/external_selinux/commit/9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc && git cherry-pick 9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc
git fetch https://github.com/PixelExperience/frameworks_base/commit/37f5a323245b0fd6269752742a2eb7aa3cae24a7 && git cherry-pick 37f5a323245b0fd6269752742a2eb7aa3cae24a7
git fetch https://github.com/PixelExperience/frameworks_opt_net_wifi/commit/3bd2c14fbda9c079a4dc39ff4601ba54da589609 && git cherry-pick 3bd2c14fbda9c079a4dc39ff4601ba54da589609
git fetch https://github.com/PixelExperience/frameworks_opt_net_ims/commit/661ae9749b5ea7959aa913f2264dc5e170c63a0a && git cherry-pick 661ae9749b5ea7959aa913f2264dc5e170c63a0a
cd ../..
