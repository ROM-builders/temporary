# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/hentaiOS/platform_manifest/ -b Rika -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/KernelPanic-OpenSource/local_manifest.git --depth 1 -b hentai-11-ng .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom

source build/envsetup.sh
lunch hentai_whyred-userdebug
export TZ=Asia/Ho_Chi_Minh #put before last build command
make -j$(nproc --all) otapackage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
