# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/BootleggersROM/manifest.git -b tirimbino -g default,-mips,-darwin,-notdefault
git clone https://github.com/Miiyo/local-manifest.git --depth 1 -b tirimbino .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build roms
lunch bootleg_akari-userdebug
source build/envsetup.sh
export WITH_GAPPS=true
export BUILD_USERNAME=exer
export BUILD_HOSTNAME=miyo
export TZ=Asia/Singapore #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
