# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/xdroid-CAF/xd_manifest -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/tempa20e/manifest --depth 1 -b evox .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch xdroid_a20e-user
export TZ=Asia/Dhaka #put before last build command
mka xd

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
