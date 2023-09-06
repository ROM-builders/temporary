repo init --depth=1 --no-repo-verify -u https://Sa-Sajjad:$ght@github.com/S-A-build/android_manifest_nusa.git -b 10 -g default,-mips,-darwin,-notdefault
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b ten .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

source build/envsetup.sh
# replace with your rom variable
lunch nad_lavender-userdebug
# time zone
export TZ=Asia/Dhaka
# SELINUX IGNORE
export SELINUX_IGNORE_NEVERALLOWS=true
# export RELAX_USES_LIBRARY_CHECK=true
# export SKIP_ABI_CHECKS=true
# export BUILD_BROKEN_VERIFY_USES_LIBRARIES=true
# export RELAX_USES_LIBRARY_CHECK=true
# don't touch
make api-stubs-docs || echo no problem
make system-api-stubs-docs || echo no problem
make test-api-stubs-docs || echo no problem
# replace with your rom variable
mka nad
# idk what is this
rclone copy out/target/product/$device/*.zip cirrus:$device -P
