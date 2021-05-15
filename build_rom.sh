# sync rom
repo init --depth=1 -u git://github.com/DerpFest-11/manifest.git -b 11-aosp -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/fourninesix/local_manifests -b derp --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# apply patch
cd frameworks/base && curl -LO https://github.com/PixelExperience/frameworks_base/commit/37f5a323245b0fd6269752742a2eb7aa3cae24a7.patch && git apply 37f5a323245b0fd6269752742a2eb7aa3cae24a7.patch
cd ../..
cd frameworks/opt/net/ims && curl -LO https://github.com/PixelExperience/frameworks_opt_net_ims/commit/661ae9749b5ea7959aa913f2264dc5e170c63a0a.patch && git apply 661ae9749b5ea7959aa913f2264dc5e170c63a0a.patch
cd ../../../..
cd frameworks/opt/net/wifi && curl -LO https://github.com/PixelExperience/frameworks_opt_net_wifi/commit/3bd2c14fbda9c079a4dc39ff4601ba54da589609.patch && git apply 3bd2c14fbda9c079a4dc39ff4601ba54da589609.patch
cd ../../../..

# build rom
source build/envsetup.sh
lunch derp_merlin-userdebug
mka derp

# upload rom
rclone copy out/target/product/merlin/DerpFest*.zip cirrus:merlin -P
