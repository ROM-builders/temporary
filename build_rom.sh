# sync rom
repo init --depth=1 --no-repo-verify -u git@github.com:LineageOS/android.git -b lineage-18.1 -g default,-mips,-darwin,-notdefault
wget -O - https://raw.githubusercontent.com/waydroid/android_vendor_waydroid/lineage-18.1/manifest_scripts/generate-manifest.sh | bash
echo '<?xml version="1.0" encoding="UTF-8"?><manifest><!-- Remove replaced Projects --><remove-project name="platform/external/libdrm" /><remove-project name="platform/external/mesa3d" /><!--  <remove-project name="platform/hardware/intel/common/libva" />--><remove-project name="LineageOS/android_packages_apps_SetupWizard" /><remove-project name="LineageOS/android_external_chromium-webview_patches" /><remove-project name="LineageOS/android_external_chromium-webview_prebuilt_arm"/><remove-project name="LineageOS/android_external_chromium-webview_prebuilt_arm64"/><remove-project name="LineageOS/android_external_chromium-webview_prebuilt_x86"/></manifest>' > .repo/local_manifests/01-removes.xml
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
apply-waydroid-patches
lunch lineage_waydroid_arm64-userdebug
export TZ=Asia/Dhaka #put before last build command
make systemimage -j8
make vendorimage -j8

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
rclone copy $OUT/* cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
