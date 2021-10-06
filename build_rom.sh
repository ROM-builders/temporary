# sync rom
repo init -u https://github.com/AICP/platform_manifest.git -b r11.1 --depth=1 --no-repo-verify -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Kitsunejasutin/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aicp_ginkgo-userdebug
export TZ=Asia/Dhaka #put before last build command
brunch ginkgo

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
