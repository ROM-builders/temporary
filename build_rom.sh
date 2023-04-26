# sync rom
repo init --depth=1 -g default,-mips,-darwin,-notdefault -u https://github.com/BootleggersROM/manifest.git -b tirimbino
git clone https://github.com/mrxzzet/local_manifests-clo -b main .repo/local_manifests
repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j$(nproc --all)

# build rom
. build/envsetup.sh
lunch bootleg_mi439-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
