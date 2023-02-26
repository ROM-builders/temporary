# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PotatoProject/manifest -b frico_mr1-release -g default,-mips,-darwin,-notdefault
git clone https://https://github.com/mhmorpheus/local_manifest --depth 1 -b test1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch potato_mido-userdebug
export TZ=Asia/Dhaka #timezone
export WITH_GMS=true #hello there
mka mido

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
