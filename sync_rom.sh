#!/bin/bash

# sync rom
repo init --depth=1 -u git://github.com/CipherOS/android_manifest.git -b eleven

git clone https://github.com/DhruvChhura/mainfest_personal.git --depth=1 -b cph .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)


