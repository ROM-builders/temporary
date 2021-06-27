# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AospExtended/manifest.git -b 11.x -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Noob-214/local_manifest.git --depth 1 -b master .repo/local_manifests
#
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


git clone https://github.com/LineageOS/android_packages_resources_devicesettings --depth=1 packages/resources/devicesettings

# build rom
source build/envsetup.sh
lunch aosp_ysl-userdebug
m aex -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
