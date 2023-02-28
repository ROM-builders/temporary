# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AfterLifePrjkt/manifest_plus.git -b 12L -g default,-mips,-darwin,-notdefault
git clone https://github.com/mitmac29/local_manifest.git --depth 1 -b main .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_lavender-userdebug
export TZ=Asia/Dhaka #put before last build command
m aex -j$(nproc --all) | tee log.txt

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
