# sync rom (Sinkron kode Sumber Rom)
repo init --depth=1 --no-repo-verify -u https://github.com/dotmod/manifest.git -b dot11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ini23/local_manifest.git --depth 1 -b dotos .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build
source build/envsetup.sh
lunch dot_whyred-userdebug
export TZ=Asia/Jakarta 
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
