# Thanks to @Apon77


# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest.git -b arrow-12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/rahmanaagung/local_manifest.git --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch arrow_wayne-buildtype
export TZ=Asia/Jakarta
export BUILD_USER=rahmanaagung
export BUILD_HOST=wayne
export BUILD_USERNAME=rahmanaagung
export BUILD_HOSTNAME=wayne
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P












