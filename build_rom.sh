# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ShapeShiftOS/android_manifest -b android_11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/SumonSN/Local-Manifests.git --depth 1 -b RMX3171 .repo/local_manifests
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch ssos_RMX3171-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
