# sync rom
repo init -u https://github.com/Project-Xtended/manifest.git -b xr -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/GangsterPlayz1/android_.repo_local_manifests.git --depth 1 .repo/local_manifests
repo sync --force-sync --no-tags --no-clone-bundle -jX


# build rom
source build/envsetup.sh
lunch xtended_RMX1801-userdebug
mka xtended

# upload rom
rclone copy out/target/product/RMX1801/xtended*.zip cirrus:RMX1801 -P
