# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/CherishOS/android_manifest.git -b twelve -g default,-mips,-darwin,-notdefault
git clone https://gitlab.com/cherishos_lava/local_manifest.git --depth 1 -b a12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
export SELINUX_IGNORE_NEVERALLOWS_ON_USER=true
source build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS_ON_USER=true
lunch cherish_lava-user
export SELINUX_IGNORE_NEVERALLOWS_ON_USER=true
export TZ=Asia/Dhaka #put before last build command
export SELINUX_IGNORE_NEVERALLOWS_ON_USER=true
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
