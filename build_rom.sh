# sync rom
repo init -u https://github.com/bananadroid/android_manifest.git -b 13 --git-lfs
git clone https://github.com/belugaA330/local_manifests.git --depth 1 -b ysl .repo/local_manifests
repo sync -c --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune
# build rom
. build/envsetup.sh
lunch banana_ysl-userdebug
export TZ=Asia/Jakarta #put before last build command
m banana
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
