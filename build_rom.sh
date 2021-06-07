# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/nitrogen-os-fan-edition/android_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/D4rkKnight21/local_manifest.git --depth 1 -b nosfe .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS=true
lunch nitrogen_platina-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
export TZ=Asia/Jakarta #put before last build command
make -j$(nproc --all) otapackage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
