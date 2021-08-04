# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Project-LegionOS/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/rajkale99/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
rm -rf packages/apps/LegionSettings && git clone -b 3.12 https://github.com/Project-LegionOS/packages_apps_LegionSettings packages/apps/LegionSettings
rm -rf frameworks/base && git clone -b 3.12 https://github.com/Project-LegionOS/frameworks_base frameworks/base
rm -rf vendor/LegionParts && git clone -b 3.12 https://github.com/Project-LegionOS/vendor_LegionParts vendor/LegionParts

# build rom
source build/envsetup.sh
export WITH_GAPPS=true
lunch legion_miatoll-userdebug
export TZ=Asia/kolkata #put before last build command
make legion


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
