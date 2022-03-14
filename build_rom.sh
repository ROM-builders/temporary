# sync rom
repo init -u https://github.com/PixelExperience/manifest -b twelve
git clone https://github.com/NRanjan-17/Android-Building.git --depth 1 -b main .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
source build/envsetup.sh
lunch aosp_mido-user
export TZ=Asia/Delhi #put before last build command
mka bacon -jX

# upload rom
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
