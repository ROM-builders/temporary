# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Spark-Rom/manifest -b pyro -g default,-mips,-darwin,-notdefault
git clone https://github.com/RintoKhan2003/local_manifest.git --depth 1 -b spark .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
rm -rf frameworks/opt/net/ims
git clone https://github.com/CherishOS/android_frameworks_opt_net_ims.git --depth 1 -b tiramisu frameworks/opt/net/ims
source build/envsetup.sh
lunch spark_RMX2020-userdebug
ALLOW_MISSING_DEPENDENCIES=true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
