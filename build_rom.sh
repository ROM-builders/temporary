# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/projectarcana-aosp/manifest.git -b 12.x -g default,-mips,-darwin,-notdefault
git clone https://github.com/ZenkaBestia/local_manifests.git --depth 1 -b 12-arcana .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch aosp_lmi-userdebug
export TZ=Asia/Dhaka #put before last build command
export SELINUX_IGNORE_NEVERALLOWS=true
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
