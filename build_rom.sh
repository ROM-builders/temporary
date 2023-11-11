# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/syberia-project/manifest.git -b 13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Shakib-BD/local_manifest.git --depth 1 -b syberia-13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# ghay cache wen stop f
source build/envsetup.sh
lunch syberia_merlinx-userdebug
export TZ=Asia/Dhaka
export BUILD_USERNAME=Shakib
export BUILD_HOSTNAME=mi
export KBUILD_USERNAME=Shakib
export KBUILD_HOSTNAME=mi
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -Ph
