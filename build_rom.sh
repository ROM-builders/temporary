repo init --depth=1 --no-repo-verify -u https://github.com/Project-Fluid/manifest.git -b fluid-12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/mizdrake7/local_manifest.git --depth 1 -b fluid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
. build/envsetup.sh
lunch fluid_r5x-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export KBUILD_BUILD_USER=MAdMiZ
export KBUILD_BUILD_HOST=MAdMiZ
export BUILD_USERNAME=MAdMiZ
export BUILD_HOSTNAME=MAdMiZ
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
