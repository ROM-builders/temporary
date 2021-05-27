# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ProtonAOSP/android_manifest -b rvc -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/RahifM/local_manifests --depth 1 -b staging/proton-rvc .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24

# build rom
source build/envsetup.sh
lunch mido-userdebug
make -j24 otapackage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
