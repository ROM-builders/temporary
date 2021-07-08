# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Project-LegionOS/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/rajkale99/local_manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch legion_miatoll-userdevug
export TZ=Asia/Dhaka #put before last build command
make legion

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/miatoll/LegionOS-v3.11-miatoll-20210709-OFFICIAL-VANILLA.zip cirrus:miatoll -P
