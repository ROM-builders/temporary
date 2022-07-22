# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u https://github.com/ProjectBlaze/manifest -b 12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Aflaungos/local_manifest.git --depth 1 -b Project-Blaze .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#17

# build rom
source build/envsetup.sh
lunch blaze_evert-userdebug
export TZ=Asia/Dhaka
export BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
export KBUILD_BUILD_USER=PaperBoy
export BUILD_HOSTNAME=PaperBoy #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
