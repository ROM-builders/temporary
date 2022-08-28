repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android -b lineage-18.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/sweervin/local_manifest --depth 1 -b 18.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

. build/envsetup.sh
lunch lineage_laurel_sprout-user
export TZ=Asia/Dhaka
m otapackage

rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
