#!/usr/bin/env bash

set -e
rom_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
branch_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
rom_name=$rom_name-$branch_name
ax613_roms=" crdroidandroid-13.0 Octavi-Staging-thirteen "
if [[ $ax613_roms != *" $rom_name "* ]]; then exit 0; fi
mkdir -p ~/roms/$rom_name
cd ~/roms/$rom_name
rm -rf .repo/local_manifests
command=$(head $CIRRUS_WORKING_DIR/build_rom.sh -n $(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1))
only_sync=$(grep 'repo sync' $CIRRUS_WORKING_DIR/build_rom.sh)
bash -c "$command" || true
 
