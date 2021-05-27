# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ProtonAOSP/android_manifest -b rvc -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/RahifM/local_manifests --depth 1 -b staging/proton-rvc .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch mido-userdebug
make -j8 otapackage

# upload rom
rclone copy out/target/product/target/proton-aosp*.zip cirrus:mido -P
