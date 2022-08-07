# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest.git -b twelve-plus -g default,-mips,-darwin,-notdefault
git clone https://github.com/LittleChest/local_manifest.git --depth 1 -b vangogh-pe12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_vangogh-user
export TZ=Asia/Shanghai
export BUILD_USERNAME=LittleChest
export BUILD_HOST=Cirrus-CI
mka bacon

# upload rom
rclone copy out/target/product/vangogh/*.zip cirrus:vangogh -P
