# sync rom
repo init -u https://github.com/Havoc-OS/android_manifest.git -b eleven
git clone https://github.com/Hashimkp/local_manifests.git --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch havoc_RMX1971-userdebug
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
export ALLOW_MISSING_DEPENDENCIES=true
brunch RMX1971

# upload rom
time rclone copy out/target/product/RMX1971/*.zip cirrus:RMX1971 -P
