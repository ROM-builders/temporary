# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ricedroidOSS/android.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone  --depth 1 https://github.com/zaidannn7/local_manifest.git -b rice2 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_chime-userdebug
export TZ=Asia/Jakarta #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
