# sync rom
repo init -q --no-repo-verify --depth=1 -u https://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefaul
git clone https://github.com/KernelPanic-OpenSource/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -v -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch lineage_whyred-userdebug
export TZ=Asia/Ho_Chi_Minh #put before last build command
mka bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
