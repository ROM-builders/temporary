# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RisingTechOSS/android -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/Simhadri07/local_manifest.git --depth 1 -b master .repo/local_manifest
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch lineage_device-userdebug/user
export TZ=Asia/Kolkata #put before last build command
mka bacon -jX

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
