# sync rom

repo init --depth=1 --no-repo-verify -u https://github.com/ResurrectionRemix/platform_manifest.git -b Q -g default,-mips,-darwin,-notdefault
git clone https://codeberg.org/omansh-krishn/local_manifest.git --depth 1 -b rrrrrrrr .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom

source build/envsetup.sh
lunch rr_santoni-userdebug

export RR_BUILDTYPE=Unofficial-OmanshKrishn
export BUILD_USERNAME=OmanshKrishn
export BUILD_HOSTNAME=pc
export KBUILD_BUILD_USER=OmanshKrishn
export KBUILD_BUILD_HOST=pc
export TZ=Asia/Kolkata

m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
