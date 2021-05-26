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

echo Test passed
