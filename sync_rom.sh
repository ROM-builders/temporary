#!/bin/bash

set -exv

# sync rom
repo init --depth=1 -u git://github.com/ForkLineageOS/android.git -b lineage-18.1 --depth=1
repo sync

#Setup
git clone https://github.com/Realme-G70-Series/vendor_realme_RMX2020.git vendor/realme/RMX2020 --depth 1
git clone https://github.com/Realme-G70-Series/device_realme_RMX2020.git device/realme/RMX2020 --depth 1
cd external/selinux && wget https://raw.githubusercontent.com/SamarV-121/android_vendor_extra/lineage-18.1/patches/external/selinux/0001-Revert-libsepol-Make-an-unknown-permission-an-error-.patch && patch -p1 < *.patch && cd ../..
cd frameworks/av && wget https://github.com/phhusson/platform_frameworks_av/commit/624cfc90b8bedb024f289772960f3cd7072fa940.patch && patch -p1 < *.patch && cd -
