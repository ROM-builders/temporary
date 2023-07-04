#!/usr/bin/env bash

set -e
mkdir -p ~/roms/$rom_name
cd ~/roms/$rom_name
rm -rf .repo/local_manifests
command=$(head $CIRRUS_WORKING_DIR/build_rom.sh -n $(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1))
only_sync=$(grep 'repo sync' $CIRRUS_WORKING_DIR/build_rom.sh)
bash -c "$command" || true
