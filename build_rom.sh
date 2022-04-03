# sync rom
repo init --depth=1 -u https://github.com/lighthouse-os/manifest.git -b sailboat_L1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/SKORPION29/local_manifest.git --depth 1 -b main .repo/local_manifests
git clone https://github.com/LineageOS/android_packages_resources_devicesettings -b lineage-19.1 packages/resources/devicesettings
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lighthouse_miatoll-userdebug
export TZ=Asia/Dhaka #put before last build command
make lighthouse

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
