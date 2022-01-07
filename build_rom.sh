#!/bin/bash

set -e
set -x

# sync rom
repo init -u https://github.com/CherishOS/android_manifest.git -b twelve
git clone https://gitlab.com/marat2509/cherishos_lava.git -b a12
mv cherishos_lava/* . -f
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
source build/envsetup.sh
lunch cherish_lava-user
export SELINUX_IGNORE_NEVERALLOWS_ON_USER=true
mka bacon
# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/lava/*.zip
