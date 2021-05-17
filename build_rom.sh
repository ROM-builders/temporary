#Sync ROM
repo init --depth=1 -u git://github.com/CipherOS/android_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/MinatiScape/local_manifest.git --depth=1 -b main .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Build ROM
. build/envsetup.sh
lunch lineage_tiare-userdebug
mka bacon -j$(nproc --all)

# upload build
rclone copy out/target/product/tiare/*UNOFFICIAL*.zip cirrus:tiare -P
