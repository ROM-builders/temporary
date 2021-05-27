# sync rom
repo init --depth=1 -u git://github.com/DotOS/manifest.git -b dot11 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/P-Salik/local_manifest --depth=1 -b DotOS .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#patches
cd frameworks/base
curl -LO https://github.com/PixelExperience/frameworks_base/commit/37f5a323245b0fd6269752742a2eb7aa3cae24a7.patch
patch -p1 < *.patch
cd ../..

# build
source build/envsetup.sh
lunch dot_RMX1941-userdebug
make bacon \
	&& repo forall -c 'git checkout .' || repo forall -c 'git checkout .'

# upload build
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
