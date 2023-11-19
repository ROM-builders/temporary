# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Spark-Rom/manifest.git -b pyro-next -g default,-mips,-darwin,-notdefault
git clone https://github.com/YudhoPatrianto/local_manifests.git --depth 1 -b 13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
chmod 777 device/xiaomi/selene/dtbo/append_certs.py
. build/envsetup.sh
lunch spark_selene-userdebug
export BUILD_USERNAME=YudhoPatrianto 
export BUILD_HOSTNAME=YudhoPRJKT
export KBUILD_BUILD_USER=$BUILD_USERNAME
export KBUILD_BUILD_HOST=$BUILD_HOSTNAME
export TZ=Asia/Jakarta #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
