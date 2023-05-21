# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/bananadroid/android_manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Assunzain/local_manifest --depth 1 -b banana .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8




# build rom
. build/envsetup.sh
lunch banana_X01AD-userdebug
export TZ=Asia/Jakarta #put before last build command
m banana
