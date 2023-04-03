#!/usr/bin/env bash
set -e
if [[ $ax613_roms != *" $rom_name "* ]]; then exit 1; fi
rm -rf ~/roms/$rom_name/out/target/product/$device
