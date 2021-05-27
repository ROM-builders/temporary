# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DotOS/manifest.git -b dot11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/MiDoNaSR545/mainfest_personal.git --depth 1 -b dot .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch dot_ysl-user
make bacon
export WITH_GAPPS=true
make bacon

# upload rom
rclone copy out/target/product/ysl/dotOS-R-v5.1-ysl-GAPPS*.zip cirrus:ysl -P

# upload rom
rclone copy out/target/product/ysl/dotOS-R-v5.1-ysl-OFFICIAL*.zip cirrus:ysl -P
