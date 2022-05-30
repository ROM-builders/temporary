# sync rom
repo init -u https://github.com/yaap/manifest.git -b twelve
git clone https://github.com/amritoj2/-local_manifest.git --depth 1 -b main .repo/local_manifest
repo sync -j$(nproc --all) --no-tags --no-clone-bundle --current-branch

# build rom
source build/envsetup.sh
lunch yaap_r5x-user
export TZ=Asia/Dhaka #put before last build command
m yaap

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
