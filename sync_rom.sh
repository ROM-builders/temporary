#!/bin/bash

set -exv

# sync rom
repo init -u https://github.com/PixelPlusUI-Elle/manifest -b eleven
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

#Setup
git clone https://github.com/Rombuilding-X00TD/device_asus_X00TD.git -b lineage-18.1 device/asus/X00TD
git clone https://github.com/Rombuilding-X00TD/proprietary_vendor_asus.git -b lineage-18.1 vendor/asus
git clone https://github.com/Rombuilding-X00TD/device_asus_sdm660-common.git -b lineage-18.1 device/asus/sdm660-common
git clone https://github.com/pkm774/kernel_asus_sdm660.git -b  master kernel/asus/sdm660
