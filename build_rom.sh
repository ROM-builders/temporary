# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/motoonepower/local-manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_chef-userdebug
export TZ=Asia/Dhaka #put before last build command
mka otapackage
rclone copy out/target/product/chef/aosp_chef-ota-retrofit-eng.cirrus.zip cirrus:chef -P
lunch aosp_chef-userdebug
