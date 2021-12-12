# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AospExtended/manifest.git -b 12.x -g default,-mips,-darwin,-notdefault
git clone https://github.com/bluecrossdev/local_manifest .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Move vendor blobs
mv vendor/gpx/* vendor/google/

# Set timezone
export TZ=Asia/Jakarta

# Extra build flags
export WITH_GAPPS=true

# Build for Pixel 3
source build/envsetup.sh
lunch aosp_blueline-user
mka aex

# Upload for Pixel 3
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

# Build for Pixel 3 XL
source build/envsetup.sh
lunch aosp_crosshatch-user
mka aex

# Upload for Pixel 3 XL
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
