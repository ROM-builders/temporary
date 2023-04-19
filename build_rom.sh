# sync rom
repo init -u https://github.com/elytraOS/manifest.git -b tesseract
git clone https://github.com/Joxquin/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync --no-clone-bundle --current-branch --no-tags --force-sync -j$(nproc --all)

# build rom
. build/envsetup.sh
lunch elytra_fog-userdebug
export TZ=Asia/Dhaka #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
