# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ShapeShiftOS/android_manifest.git -b android_11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/GhostMaster69-dev/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j8

# CCache
export USE_CCACHE=1

# build rom
source build/envsetup.sh
lunch ssos_vince-userdebug
export TZ=Asia/Kolkata #put before last build command
make bacon -j8

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
