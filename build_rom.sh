# sync rom
repo init --depth=1 -u https://github.com/PixelPlusUI-SnowCone/manifest -b snowcone-12.1
git clone https://github.com/NamCap25/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
. build/envsetup.sh
breakfast spes
lunch aosp_spes-user
rm -rf hardware/xiaomi/hidl/powershare/Android.bp
rm -rf hardware/xiaomi/hidl/touch/Android.bp
rm -rf hardware/google/pixel/kernel_headers/Android.bp
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
