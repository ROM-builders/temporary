#!/bin/bash

# Sync rom
repo init --depth=1 -u https://github.com/Corvus-R/android_manifest.git -b 11
git clone https://github.com/yashlearnpython/local_manifest.git -b corvus .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j"$(nproc --all)"
df -h

# Build rom
source build/envsetup.sh
lunch corvus_mido-user
make corvus -j"$(nproc --all)"

# Upload rom
for LOOP in out/target/product/mido/*.zip; do
	rclone copy "$LOOP" cirrus:mido -P
done
