# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b udc -g default,-mips,-darwin,-notdefault
git clone https://github.com/dogpoopy/android_build_manifest.git --depth 1 -b Evolution-X .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j4

## build rom
source build/envsetup.sh
lunch evolution_vayu-userdebug
# timezone
export TZ=Asia/Manila
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
