# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Spark-Rom/manifest -b spark -g default,-mips,-darwin,-notdefault
git clone https://github.com/NFS86/local_manifest --depth 1 -b aex-12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom 
source build/envsetup.sh
lunch spark_rosy-userdebug
export TZ=Asia/Jakarta
export BUILD_USER=finix
export BUILD_HOST=rosy
export BUILD_USERNAME=finix
export BUILD_HOSTNAME=rosy
mka spark

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
