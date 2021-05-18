# sync rom
repo init --depth=1 -u https://github.com/PixelBlaster-OS/manifest -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Apon77Lab/android_.repo_local_manifests.git --depth 1 -b aex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_mido-user
m aex

# upload rom
rclone copy out/target/product/mido/*.zip cirrus:mido -P
