#!/bin/bash
set -e

init_check=$(grep 'repo init' $CIRRUS_WORKING_DIR/build_rom.sh | grep 'depth=1')
if [[ $init_check != *default,-device,-mips,-darwin,-notdefault* ]]
then
	echo Please use --depth=1 and -g default,-device,-mips,-darwin,-notdefault tags in repo init line.
	exit 1
fi

clone_check=$(grep 'git clone' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $clone_check -gt 1 ]]
then
	echo Please use local manifest to clone trees and other repositories, we dont allow git clone to clone trees.
	exit 1
fi

rm_check=$(grep 'rm -rf' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $rm_check -gt 0 ]]
then
	echo Please dont use rm -rf inside script, use local manifest for this purpose.
	exit 1
fi

clean_check=$(grep ' clean' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $clean_check -gt 0 ]]
then
	echo Please dont use make clean. Server does make installclean by default, which is enough for most of the cases. 
	exit 1
fi

clobber_check=$(grep ' clobber' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $clobber_check -gt 0 ]]
then
	echo Please dont use make clobber. Server does make installclean by default, which is enough for most of the cases. 
	exit 1
fi

rclone_check=$(grep 'rclone copy' $CIRRUS_WORKING_DIR/build_rom.sh)
rclone_string="rclone copy out/target/product/\$(grep unch \$CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:\$(grep unch \$CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P"
if [[ $rclone_check != *$rclone_string* ]]
then
	echo Please follow rclone copy line of main branch.
	exit 1
fi

sync_check=$(grep 'repo sync' $CIRRUS_WORKING_DIR/build_rom.sh)
sync_string="repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j"
if [[ $sync_check != *$sync_string* ]]
then
	echo Please follow repo sync line of main branch.
	exit 1
fi

echo Test passed
