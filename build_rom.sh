# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Project-Awaken/android_manifest.git -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Kendras056/local_manifests.git --depth 1 -b derp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) 

# build rom
source build/envsetup.sh
lunch awaken_X00TD-userdebug
export BUILD_USERNAME=venom
export BUILD_HOSTNAME=android-build
export TZ=Asia/Jakarta
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
