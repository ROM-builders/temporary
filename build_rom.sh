# sync rom 
repo init --depth=1 --no-repo-verify -u https://github.com/PixelBlaster-OS/manifest.git -b eleven -g default,-mips,-darwin,-notdefault
git clone https://github.com/RAAVANDK/Local_Manifest.git --depth 1 -b RAAVANDK .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 
# build rom

. build/envsetup.sh
lunch aosp_merlinx-userdebug
export TZ=Asia/kolkata 
make bacon -j8

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
