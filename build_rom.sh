# sync roms
repo init --depth=1 --no-repo-verify -u https://github.com/bananadroid/android_manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/hklknz/Local-Manifests.git --depth 1 -b tissot-bananadroidCoreGApps .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch banana_tissot-userdebug
export TZ=Asia/Tokyo #put before last build command
m banana
export KBUILD_BUILD_USER=hklknz
export KBUILD_BUILD_HOST=Roselia-CI
export BUILD_USERNAME=hklknz
export BUILD_HOSTNAME=Roselia-CI

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
