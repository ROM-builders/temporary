# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/snnbyyds/local_manifests.git --depth 1 -b arrow-13.0 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
bash ./fun/blobs.sh
croot
lunch arrow_fajita-user
export KBUILD_BUILD_USER=snnbyyds
export KBUILD_BUILD_HOST=uotan
export BUILD_USERNAME=snnbyyds
export BUILD_HOSTNAME=uotan
export TZ=Asia/Shanghai #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
