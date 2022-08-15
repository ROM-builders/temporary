# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Project-Fluid/manifest.git -b fluid-12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ShahzebQureshi/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export BUILD_USER=ShahzebQureshi
export BUILD_HOST=cirrus-ci
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=cirrus-ci
lunch fluid_joan-user
export TZ=Asia/Karachi #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
