# sync rom
repo init --depth=1 --no-repo-verify -u git://repo init -u https://github.com/bananadroid/android_manifest.git -b 13 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/iamrh1819/local_manifest.git --depth 1 -b bananadroid-13 .repo/local_manifests
#repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune

# build rom
source build/envsetup.sh
lunch banana_a10-userdebug
export BUILD_BROKEN_MISSING_REQUIRED_MODULES= true 
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true
export BUILD_BROKEN_DUP_RULES=true 
m banana
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
