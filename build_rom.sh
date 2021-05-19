# sync rom
repo init --depth=1 -u https://github.com/PotatoProject/manifest -b dumaloo-release; -g default,-device,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch potato_violet-user
brunch violet

# upload rom
rclone copy out/target/product/violet/*.zip cirrus:mido -P
