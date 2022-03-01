# sync rom
repo init --depth=1 --no-repo-verify -u -u https://github.com/PixelExperience/manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/Snowman2409/local-manifest --depth=1 -b potato .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle -
# build rom
source build/envsetup.sh
lunch aosp_$device-userdebug
export TZ=Asia/Kolkata #put before last build command
export WITH_GMS=true
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
