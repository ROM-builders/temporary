# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/ForkLineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/RahulPalXDA/local_manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_X00TD-userdebug
make bacon -j$(nproc --all)

# upload rom
rclone copy out/target/product/X00TD/*.zip cirrus:X00TD -P
