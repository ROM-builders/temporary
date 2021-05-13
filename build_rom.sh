# sync rom
repo init --depth=1 -u https://github.com/StagOS/manifest.git -b r11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/kardebayan/local_manifests.git --depth 1 -b r11 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch stag_CPH1859-eng
make installclean && make stag

# upload rom
rclone copy out/target/product/CPH1859/StagOS*.zip cirrus:CPH1859 -P
