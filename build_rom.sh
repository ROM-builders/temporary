# sync rom
repo init -u https://github.com/CherishOS/android_manifest.git -b eleven 
git clone https://github.com/Yasundram/local_manifest --depth 1 -b aex .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
. build/envsetup.sh
 brunch RMX1941-userdebug

# upload rom
rclone copy out/target/product/RMX1941/*.zip cirrus:RMX1941 -P
