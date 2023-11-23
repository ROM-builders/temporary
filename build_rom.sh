# sync rom
repo init -u https://github.com/SuperiorOS/manifest.git -b thirteen
git clone https://github.com/belugaA330/local_manifest.git --depth 1 -b master.repo/local_manifest
repo sync -c --force-sync --no-clone-bundle --no-tags
+
# build rom
source build/envsetup.sh
lunch superior_ysl-userdebug
export KBUILD_BUILD_USER=beluga
export KBUILD_BUILD_HOST=beluga330
export BUILD_USERNAME=beluga
export BUILD_HOSTNAME=beluga330
export TZ=Asia/Jakarta #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
