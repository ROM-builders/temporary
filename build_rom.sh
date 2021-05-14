#!/bin/bash
# shellcheck disable=SC1091

# Sync rom
repo init --depth=1 -u https://github.com/Corvus-R/android_manifest.git -b 11
git clone https://github.com/jrchintu/local_manifest.git --depth=1 -b corvus .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j"$(nproc --all)"

# Build rom
source build/envsetup.sh
lunch corvus_mido-user
make corvus -j"$(nproc --all)"

# Upload rom
up(){
	curl --upload-file "$1" https://transfer.sh/"$(basename "$1")"; echo
}

for LOOP in out/target/product/mido/*.zip; do
	up "$LOOP"
	echo "$LOOP"
done
