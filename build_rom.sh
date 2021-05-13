# sync rom
repo init --depth=1 -u git://github.com/ShapeShiftOS/android_manifest.git -b android_11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Unknownbitch07/local_manifest.git --depth=1 -b ssos .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# build rom
source build/envsetup.sh
lunch ssos_tissot-userdebug
make bacon

# upload rom
rclone copy out/target/product/tissot/ShapeShiftOS*.zip cirrus:mido -P
