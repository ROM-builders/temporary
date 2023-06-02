# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RisingTechOSS/android -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/ozipoetra/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
source build/envsetup.sh
lunch lineage_merlinx-user
export TZ=Asia/Jakarta #put before last build command
export RISING_CHIPSET=MT6769Z
export RISING_MAINTAINER=ozipoetra
export RISING_PACKAGE_TYPE=PIXEL
export TARGET_BUILD_APERTURE_CAMERA=true
export TARGET_ENABLE_BLUR=false
export TARGET_HAS_UDFPS=true
export TARGET_USE_PIXEL_FINGERPRINT=false
export WITH_GMS=true
export TARGET_CORE_GMS=false
export TARGET_USE_GOOGLE_TELEPHONY=true
export TARGET_CORE_GMS_EXTRAS=true
mka bacon
make updatepackage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
