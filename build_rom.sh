# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Corvus-R/android_manifest.git -b 12-test -g default,-mips,-darwin,-notdefault
git clone https://github.com/ugly-saifu/local_manifest.git -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export USE_CCACHE=1
ccache -M 50G
export CONFIG_STATE_NOTIFIER=y
export SELINUX_IGNORE_NEVERALLOWS=true
lunch corvus_X01AD-userdebug
ALLOW_MISSING_DEPENDENCIES=true
export TZ=Asia/Dhaka #put before last build command
make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
