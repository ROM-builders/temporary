# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/hdzungx/local_manifest --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export TZ=Asia/Asia/Bangkok #put before last build command
export SELINUX_IGNORE_NEVERALLOWS=true
export WITH_GMS=true
export BUILD_USER=HDzungx
export BUILD_HOST=cloud
export BUILD_USERNAME=HDzungx
export BUILD_HOSTNAME=cloud
brunch munch
