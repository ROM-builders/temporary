repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest -b arrow-12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/sweervin/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

. build/envsetup.sh
export ARROW_GAPPS=true
lunch arrow_laurel_sprout-userdebug
export TZ=Asia/Dhaka
m bacon

##FuckAOSP

rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
