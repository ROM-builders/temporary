# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/SuperiorOS/manifest.git -b twelvedotone -g default,-mips,-darwin,-notdefault
git clone https://github.com/Snowman2409/local-manifest --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
# build rom
source build/envsetup.sh
lunch superior_lavender-userdebug
export BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
export SELINUX_IGNORE_NEVERALLOWS=true

mka bacon 

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
 
