# sync rom
repo init --depth=1 -u git://github.com/Corvus-R/android_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/AhmedElwakil2004/local_manifest_test.git --depth=1 -b corvus .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch corvus_mido-userdebug
mka corvus

# upload rom
rclone copy out/target/product/mido/Corvus-R*.zip cirrus:mido -P
