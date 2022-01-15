# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/SuperiorOS/manifest.git -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/lynnnnzx/local_manifest.git --depth 1 -b twelve-superior .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom 
. build/envsetup.sh
lunch superior_juice-userdebug
export BUILD_USERNAME=lynx
export KBUILD_BUILD_USER=LynZx
export KBUILD_BUILD_HOST=Cirrus-CI
export BUILD_WITH_GAPPS=true
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Jakarta
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

