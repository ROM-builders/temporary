# sync rom
repo init -u https://github.com/ProjectBlaze/manifest.git -b 12.1
git clone  https://github.com/PrajwalGoli/Hello-world --depth 1 -b main .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune

# build rom
source build/envsetup.sh
lunch blaze_lavender-userdebug
export WITH_GMS=true
export TZ=Asia/Dhaka #put before last build command
brunch lavender

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
