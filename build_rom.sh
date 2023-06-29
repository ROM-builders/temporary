# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u https://github.com/BootleggersROM/manifest.git -b tirimbino -g default,-mips,-darwin,-notdefault
git clone https://github.com/Burhanverse/local_manifest.git --depth 1 -b btlg .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# wen make everything properly sur
source build/envsetup.sh
lunch bootleg_lancelot-userdebug

export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_USERNAME=burhan 
export BUILD_HOSTNAME=burhan 
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
