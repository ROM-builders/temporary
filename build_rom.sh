# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/yaap/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/z3zens/local_manifest.git --depth 1 -b yaap .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom 
source build/envsetup.sh
lunch yaap_X01BD-userdebug
export BUILD_USERNAME=nobody
export BUILD_HOSTNAME=android-build
export KBUILD_BUILD_USER=nobody
export KBUILD_BUILD_HOST=android-build
export TZ=Asia/Jakarta #put before last build command 
m yaap
