# sync rom
repo init --depth=1 --no-repo-verify -u git://https://github.com/Project-Awaken/android_manifest.git -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Project-Awaken/android_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch awaken-fagita-ace120ms
export TZ=Asia/Dhaka #put before last build command
make bacon -j$(nproc --all)


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
