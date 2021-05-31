# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/NusantaraProject-ROM/android_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/Fraschze97/local_manifest.git --depth 1 -b nusantara .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# patches
cd frameworks/opt/net/wifi
curl -LO https://github.com/Fraschze97/android_frameworks_opt_net_wifi/commit/d53535f92adba2780cc77b5549a815b75d2e3b2a.patch
patch -p1 < *.patch
cd ../..

. build/envsetup.sh
lunch nad_RMX1941-userdebug
mka nad


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/RMX1941/NusantaraProject*.zip cirrus:RMX1941 -P