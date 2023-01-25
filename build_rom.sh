# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android -b lineage-20.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/paulowesll/local_manifest --depth 1 -b m52xq .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build roms
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch lineage_m52xq-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
