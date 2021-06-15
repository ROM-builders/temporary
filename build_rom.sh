# sync rom
repo init --depth=1 -u git://github.com/CherishOS/android_manifest -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/KernelPanic-OpenSource/local_manifest.git --depth 1 -b cherish .repo/local_manifests
repo sync -v -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
export SKIP_ABI_CHECKS=true
export TZ=Asia/Ho_Chi_Minh #put before last build command
export CHERISH_NONGAPPS=true #Non-Gapps
# export CHERISH_WITHGAPPS=true #Gapps
lunch cherish_whyred-userdebug
mka bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
