#!/bin/bash

set -exv

# sync rom
repo init -u  git://github.com/crdroidandroid/android.git -b 11.0 --depth=1
git clone https://github.com/flashokiller/mainfest_presonal--depth=1  .repo/local_manifests -b aex
repo sync --force-sync --no-tags --no-clone-bundle


#uild rom
. build/envsetup.sh
lunch aosip_ysl-userdebug
time m kronic
