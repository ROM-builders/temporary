# sync rom
repo init --depth=1 -u git://github.com/P-404/platform_manifest.git -b rippa -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Project404-whyred/local_manifests --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# build rom
source build/envsetup.sh
lunch p404_whyred-userdebug
make bacon

# upload rom
rclone copy out/target/product/whyred/project-404*.zip cirrus:giovannirn5 -P
