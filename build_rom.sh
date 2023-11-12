# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/SuperiorOS/manifest.git -b fourteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/Ritikk11/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch superior_lavender-user
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true
export BUILD_BROKEN_DUP_RULES=true
#export awaken_GAPPS=minimal
export TZ=Asia/Jakarta #put before last build command
#make bacon
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
