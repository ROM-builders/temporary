# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Wave-Project/manifest -b r -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Abhinavftp/local_manifest.git --depth 1 -b los .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch wave_RMX1805-userdebug
make brunch

# upload rom 
rclone copy out/target/product/RMX1805/*UNOFFICIAL*.zip cirrus:RMX1805 -P
 
