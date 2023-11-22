# sync rom
repo init -u https://github.com/SuperiorOS/manifest.git -b thirteen-aosp-qp
git clone https://github.com/belugaA330/local_manifest --depth 1 -b ysl.repo/local_manifest
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
. build/envsetup.sh
lunch superior_ysl-userdebug
m bacon -j$(nproc --all)
export KBUILD_BUILD_USER=beluga
export KBUILD_BUILD_HOST=beluga330
export BUILD_USERNAME=beluga
export BUILD_HOSTNAME=beluga330

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

SuperiorOS-thirteen
