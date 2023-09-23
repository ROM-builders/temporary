# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RisingTechOSS/android -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/Asce-XOX/local_manifest.git --depth 1 -b rise .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


#flags
RISING_CHIPSET := "Mt6768"
RISING_MAINTAINER := "Asce||エース°"
RISING_PACKAGE_TYPE := "AOSP"
TARGET_BUILD_APERTURE_CAMERA := true
TARGET_ENABLE_BLUR := false
TARGET_HAS_UDFPS := false
TARGET_USE_PIXEL_FINGERPRINT := true

#GMS
WITH_GMS := true
TARGET_USE_GOOGLE_TELEPHONY := false
TARGET_CORE_GMS := true
TARGET_CORE_GMS_EXTRAS := true


# build rom
source build/envsetup.sh
lunch lineage_lancelot-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon 

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
