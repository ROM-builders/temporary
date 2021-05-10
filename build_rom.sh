#!/bin/bash

set -exv

#Setup
rm -rf hardware/ril/libril vendor/qcom/opensource/power && git clone https://github.com/nnippon/android_vendor_qcom_opensource_power -b 11 vendor/qcom/opensource/power

# build rom
source build/envsetup.sh
lunch styx_j4primelte-userdebug
m styx-ota
