# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/StagOS/manifest.git -b t13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/rinto02/local_manifest.git --depth 1 -b stag .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export KBUILD_BUILD_USER=Rinto
export KBUILD_BUILD_HOST=Rinto
export BUILD_USERNAME=Rinto
export BUILD_HOSTNAME=Rinto
LOCAL_MODULE_TAGS=userdebug
lunch stag_RMX2020-userdebug
export TZ=Asia/Dhaka #put before last build command
make stag

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
