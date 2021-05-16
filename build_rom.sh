# sync rom
repo init --depth=1 -u https://github.com/arulebin/android_manifest.git -b eleven
git clone https://github.com/arulebin/local_manifest.git -b cph .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
export CIPHER_OFFICIAL=true
lunch lineage_rosy-userdebug
make bacon -j$(nproc --all)

# upload rom
rclone copy out/target/product/rosy/*.zip cirrus:rosy -P
