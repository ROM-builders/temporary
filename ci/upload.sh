#!/usr/bin/env bash
set -e
rom_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
branch_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
rom_name=$rom_name-$branch_name
ax613_roms=" crdroidandroid-13.0 Octavi-Staging-thirteen "
if [[ $ax613_roms != *" $rom_name "* ]]; then exit 0; fi
device=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
grep _jasmine_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=jasmine_sprout
grep _laurel_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=laurel_sprout
grep _GM8_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=GM8_sprout
grep _maple_dsds $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=maple_dsds
cd ~/roms/$rom_name
engzip=$(ls out/target/product/$device/*-eng*.zip | grep -v "retrofit" || true)
otazip=$(ls out/target/product/$device/*-ota-*.zip | grep -v "hentai" | grep -v "evolution" || true)
awaken=$(ls out/target/product/$device/Project-Awaken*.zip || true)
octavi=$(ls out/target/product/$device/OctaviOS-R*.zip || true)
p404=$(ls out/target/product/$device/?.*zip || true)
cipher=$(ls out/target/product/$device/CipherOS-*-OTA-*.zip || true)
rm -rf $engzip $otazip $awaken $octavi $p404 $cipher
dlink=$(basename out/target/product/$device/*.zip)
unzip -P $one -q ~/.config/1.zip -d ~
file=out/target/product/$device/*.zip
rsync -vhcP $file -e "ssh -o Compression=no" apon77@frs.sourceforge.net:/home/frs/project/rom-builders/$device/
echo "Download link https://sourceforge.net/projects/rom-builders/files/$device/$dlink/download"
