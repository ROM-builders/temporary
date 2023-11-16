# sync rom
repo init -u https://github.com/pixeldust-project-caf/manifest -b tartufo-qpr3 -g default,-mips,-darwin,-notdefault
git clone https://github.com/mintss-zez0/local_manifest.git --depth 1 -b tartufo-qpr3 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom [07]
source build/envsetup.sh
lunch pixeldust_sky-userdebug
export KBUILD_BUILD_USER=arm
export KBUILD_BUILD_HOST=debug
export BUILD_USERNAME=arm
export BUILD_HOSTNAME=debug
export TZ=Asia/Bangkok # put before last build command
./rom-build.sh sky -t userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
