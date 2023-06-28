# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Spark-Rom/manifest -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/CEKIKOFGAMERS/local_manifest.git --depth 1 -b moonstone .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch moonstone_spark-userdebug
export TZ=Asia/Jakarta #put before last build command
export WITH_GAPPS=false
export KBUILD_USERNAME=Kristoforusapm
export KBUILD_HOSTNAME=Kristoforusapm
export BUILD_USERNAME=Kristoforusapm
export BUILD_HOSTNAME=Kristoforusapm
mka spark

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
