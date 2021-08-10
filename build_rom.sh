# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ResurrectionRemix/platform_manifest.git -b Q -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/zhantech/Local-Manifests.git --depth 1 -b rr-ginkgo .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# DSB & Like Octavi
cd packages/apps/Settings
git fetch https://github.com/zhantech/Resurrection_packages_apps_Settings Q
git cherry-pick 777568fe6127701244608b88ac469218cab7cc56
git cherry-pick e0ec3efe40301322a710c4eb756eb6500d0964a7
cd ../../..

# DSB
cd frameworks/base
git fetch https://github.com/zhantech/android_frameworks_base Q
git cherry-pick d1e0af17c1d4086ad77ba1843ebcdde8755beaab
cd ../..

# Lawnchair
cd vendor/rr
git fetch https://github.com/zhantech/android_vendor_resurrection Q
git cherry-pick f2dc3b62c2c5e969671bdb4095f1a0295b16f7a0
cd ../..

# Kernel
cd kernel/xiaomi/ginkgo
git fetch https://github.com/zhantech/android_kernel_xiaomi_ginkgo sixteen-Q
git cherry-pick ba912813e7cd5b961e309978ada4bfacdad279d9
cd ../../..

# Build Rom
source build/envsetup.sh
export KBUILD_BUILD_USER="ZHANtech"; export KBUILD_BUILD_HOST="gatotkaca"
export TZ=Asia/Dhaka #put before last build command
brunch rr_ginkgo-user

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
