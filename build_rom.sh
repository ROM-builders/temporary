# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Fusion-OS/android_manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/XenStuff/manifest --depth 1 -b proton .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export KBUILD_BUILD_USER=xenxynon 
export KBUILD_BUILD_HOST=xenxynon 
export BUILD_USERNAME=xenxynon
export BUILD_HOSTNAME=xenxynon
lunch fuse_lavender-user
export WITH_GAPPS=true
export TZ=Asia/Kolkata #put before last build command
make fuse-prod

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
