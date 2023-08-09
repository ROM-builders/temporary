#!/usr/bin/env bash
set -e
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
rsync -vhcP -e ssh $file apon77@frs.sourceforge.net:/home/frs/project/rom-builders/$device/
echo "Download link https://sourceforge.net/projects/rom-builders/files/$device/$dlink/download"
