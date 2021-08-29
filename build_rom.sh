# sync rom

repo init --depth=1 --no-repo-verify -u git://github.com/HyconOS/manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/kryptoniteX/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch aosp_X01BD-userdebug
export HYCON_BUILD_TYPE=OFFICIAL #put before last build command
export ALLOW_MISSING_DEPENDENCIES=TRUE
mka bacon
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/X01BD/*.zip cirrus:X01BD -P && rclone copy out/target/product/X01BD/*.zip.json cirrus:X01BD -P
