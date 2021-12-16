# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/aex-tmp/manifest.git -b 12.x -g default,-mips,-darwin,-notdefault
git clone https://github.com/ping2109/local_manifest.git --depth 1 -b aex-mido .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_mido-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
# export SKIP_ABI_CHECKS=true
# export RELAX_USES_LIBRARY_CHECK=true
export ALLOW_MISSING_DEPENDENCIES=true
export TZ=Asia/HoChiMinh #put before last build command
m aex

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
