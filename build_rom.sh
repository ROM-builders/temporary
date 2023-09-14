# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RisingTechOSS/android.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/Ritikk11/local_manifest.git --depth 1 -b main .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
brunch "device_lavender" userdebug
lunch lineage_lavender-userdebug
mka bacon -jX
lunch lineage_lavender-userdebug
export RISING_CHIPSET=SDM660
export RISING_MAINTAINER=Ritikk11
export TARGET_ENABLE_BLUR := true
export TARGET_BUILD_APERTURE_CAMERA := true
export TARGET_USE_PIXEL_FINGERPRINT := true
export TZ=Asia/Dhaka
make updatepackage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
