# sync rom
repo init --depth=1 -u git://github.com/crdroidandroid/android.git -b 11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Sohil876/android_.repo_local_manifests --depth 1 -b crdroid-tissot .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_tissot-user
make bacon

# upload rom
rclone copy out/target/product/tissot/crDroidAndroid*.zip cirrus:tissot -P
