# sync rom
repo init -u https://github.com/Project-Awaken/android_manifest -b 12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/LuffyTaro008/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# build rom
   source build/envsetup.sh
   lunch awaken_vayu-userdebug
   export BUILD_HOSTNAME=luffytaro008
   export BUILD_USERNAME=luffytaro008
   export TZ=Asia/Jakarta #put before last build command
   make bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
