# sync rom
repo init --depth=1 -u git://github.com/AospExtended/manifest.git -b 11.x -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Apon77Lab/android_.repo_local_manifests.git --depth 1 -b aex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# build rom
source build/envsetup.sh
lunch aosp_mido-user
m aex

# upload rom
device=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1)
rclone copy out/target/product/mido/AospExtended*.zip cirrus:$device -P
