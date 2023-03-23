# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ProjectBlaze/manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/omansh-krishn/local_manifest --depth 1 -b blaze13-proton .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export BUILD_USERNAME=OmanshKrishn
export BUILD_HOSTNAME=Arch
export KBUILD_BUILD_USER=OmanshKrishn
export KBUILD_BUILD_HOST=Arch
export ALLOW_MISSING_DEPENDENCIES=true
source build/envsetup.sh
lunch blaze_santoni-userdebug
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
