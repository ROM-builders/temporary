# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/NusantaraProject-ROM/android_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ayashaa/local-manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source device/xiaomi/ginkgo/setup-ginkgo.sh
source build/envsetup.sh
lunch nad_ginkgo-user
export TZ=Asia/Jakarta #put before last build command
mka nad

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
