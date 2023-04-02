#!/usr/bin/env bash
set -e
if [[ $ax613_roms != *" $rom_name "* ]]; then exit 0; fi
rm -rf ~/roms/$rom_name/out/target/product/$device
