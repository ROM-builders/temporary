# sync rom
repo init -u https://github.com/Spark-Rom/manifest -b pyro
git clone https://github.com/Chkpon54/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# build rom
build/env*
lunch spark_lancelot-userdebug
export WITH_GAPPS=false
export TZ=Asia/Dhaka
mka bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
