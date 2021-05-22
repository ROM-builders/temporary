# sync rom
repo init --depth=1 -u https://github.com/PotatoProject/manifest -b dumaloo-release -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/galanteria01/local_manifest.git -b posp --depth 1 .repo/local_manifests 
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
sudo apt update && sudo apt -y install cpio
source build/envsetup.sh
lunch potato_violet-userdebug
brunch violet

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/violet/Potato_violet*Community.zip cirrus:violet -P
