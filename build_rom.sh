# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch derp_vayu-user
mka derp

# upload rom
rclone copy out/target/product/vayu/DerpFest*.zip cirrus:vayu -P
