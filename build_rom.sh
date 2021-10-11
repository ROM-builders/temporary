# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/samsungexynos7870/android_manifest_samsung_j6lte.git --depth 1 -b lineage-18.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_j6lte-eng
export TZ=Asia/Dhaka
mka bacon

# 101021 := manifest updates in j6lte device tree
# 101021-23:12 := vintf updates, hopefully this time will boot, also switch to userdebug build
# 101121-08:39 := switch to oss HWC, switch to eng build to debug boot
# 101121-11:22 := fix fatal error in manifest
# 101121-14:28 := hwc didn't work, dirty fix hwc then
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
