# sync rom
repo init -u https://github.com/bananadroid/android_manifest.git -b 13
git clone https://github.com/ItsMeAlcazar/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune

# build rom
source build/envsetup.sh
lunch banana_ysl-eng
export TZ=Asia/Dhaka #put before last build command
m banana -j6

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
