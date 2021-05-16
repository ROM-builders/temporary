# sync rom
repo init --depth=1 -u git://github.com/ShapeShiftOS/android_manifest.git -b android_11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/MiDoNaSR545/mainfest_personal.git --depth 1 -b ssos .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch ssos_ysl-user
make bacon

# upload rom
rclone copy out/target/product/ysl/ShapeShiftOS-2.6*.zip cirrus:mido -P
