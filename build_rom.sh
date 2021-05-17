# sync rom
repo init --depth=1 -u https://github.com/descendant-xi/manifests.git -b eleven-staging -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/MiDoNaSR545/mainfest_personal.git --depth 1 -b de .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch descendant_ysl-user
mka descendant

# upload rom
rclone copy out/target/product/ysl/*.zip cirrus:ysl -P

# upload again if rclone fail
cd out/target/product/ysl
curl -sL https://git.io/file-transfer | sh && ./transfer wet *.zip
