# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RiceDroid/android -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/rushiranpise/local_manifest --depth 1 -b crdroid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_chef-userdebug
export RICE_MAINTAINER=rushi24
export RICE_CHIPSET=sdm660
export WITH_GMS=false
export RICE_OFFICIAL=true
export SUSHI_BOOTANIMATION=1080
export TARGET_BUILD_GRAPHENEOS_CAMERA=true
export TARGET_ENABLE_BLUR=true
export TARGET_SUPPORTS_QUICK_TAP=true
export TARGET_FACE_UNLOCK_SUPPORTED=true
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
#2
