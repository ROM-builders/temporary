#!/usr/bin/env bash

set -e
if [[ $ax613_roms != *" $rom_name "* ]]; then exit 0; fi
export CCACHE_DIR=~/ccache/$rom_name/$device
ccache -s
