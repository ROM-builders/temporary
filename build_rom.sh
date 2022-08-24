# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/darknius20/local_manifest --depth 1 -b aicp12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aicp_juice-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true
export BUILD_BROKEN_DUP_RULES=true
export TZ=Asia/Jakarta #put before last build command
export BUILD_USERNAME="darknius"
export BUILD_HOSTNAME="darx-labs"
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
