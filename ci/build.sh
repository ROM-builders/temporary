#!/usr/bin/env bash

set -e
cd ~/roms/$rom_name
export CCACHE_DIR=~/ccache/$rom_name/$device
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 8G
ccache -z
ls device/*/*/vendorsetup.sh | grep -v generic && echo "Please remove vendorsetup.sh file from device tree, use local manifest for cloning and removing repositories." && exit 1 || true
if [[ " LineageOS-cm-14.1 LineageOS-lineage-15.1 LineageOS-lineage-16.0 " == *"$rom_name"* ]]; then sudo mkdir -p /usr/share/man/man1; sudo apt update; sudo apt install openjdk-8-jdk --no-install-recommends -y; sudo curl -L -o /etc/java-8-openjdk/security/java.security https://raw.githubusercontent.com/Apon77Lab/repo_update/java/java.security; sudo ln -sf /usr/bin/python2 /usr/bin/python; fi
command=$(tail $CIRRUS_WORKING_DIR/build_rom.sh -n +$(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1)| head -n -1 | grep -v 'rclone copy')
bash -c "$command"

succeed_date=$(date +%s)
curl -X PATCH "$two?cirrus_build_id=eq.https://cirrus-ci.com/build/$CIRRUS_BUILD_ID" -H "apikey: $three" -H "Authorization: Bearer $four" -H "Content-Type: application/json" -H "Prefer: return=minimal" -d "{ \"succeed_date\": \"$succeed_date\" }"
