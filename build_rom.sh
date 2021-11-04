# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b elle -g default,-mips,-darwin,-notdefault
git clone https://github.com/ishakumari772/local_manifest --depth 1 -b evox .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_chiron-userdebug
export TZ=Asia/Dhaka 
mka evolution -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

