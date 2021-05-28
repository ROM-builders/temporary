# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DotOS/manifest.git -b dot11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Hmm0/local_manifest.git --depth 1 -b dot .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch dot_land-userdebug
make bacon

# upload rom
rclone copy out/target/product/land/dotOS*.zip cirrus:land -P
