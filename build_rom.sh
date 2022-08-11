# sync rom
repo init --depth=1 -u https://github.com/ConquerOS/manifest.git -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/dikiawan-9/manifest.git --depth 1 -b conquer .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch conquer_lavender-userdebug
export TZ=Asia/Jakarta
export BUILD_USERNAME=dikiawan-9
export SELINUX_IGNORE_NEVERALLOWS=true
brunch carthage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
