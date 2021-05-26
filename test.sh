#!/bin/bash
set -e

init_check=$(grep 'repo init' $CIRRUS_WORKING_DIR/build_rom.sh | grep 'depth=1')
if [[ $init_check != *default,-device,-mips,-darwin,-notdefault* ]]
then
	echo Please use depth=1 and -g default,-device,-mips,-darwin,-notdefault tags in repo init line
	exit 1
fi

clone_check=$(grep 'git clone' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $clone_check -gt 1 ]]
then
	echo Please use local manifest to clone trees and other repositories, we dont allow git clone to clone trees
	exit 1
fi

rm_check=$(grep 'rm -rf' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $rm_check -gt 0 ]]
then
	echo Please dont use rm -rf inside script, use local manifest for this purpose
	exit 1
fi

device=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
rom_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
username=$(grep 'git clone' $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)

ls ~/roms/$device-$rom_name-$username/*/*/*/vendorsetup.sh > /dev/null 2>&1 && echo Please remove vendorsetup.sh from device tree, use local manifest for this purpose https://github.com/Apon77Lab/android_.repo_local_manifests/tree/tutorial || true

echo Test passed
