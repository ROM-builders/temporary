# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-18.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/dkey5/local_manifests.git --depth 1 -b j7elte_lineage-18.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
breakfast j7elte
export TZ=Europe/Istanbul #put before last build command
croot
brunch j7elte

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
zip out/target/product/j7elte/lineage-18.1-20220902-recovery.zip out/target/product/j7elte/recovery.img
rclone copy out/target/product/j7elte/lineage-18.1-20220902-UNOFFICIAL-j7elte.zip cirrus:j7elte -P
rclone copy out/target/product/j7elte/lineage-18.1-20220902-recovery.zip cirrus:j7elte -P
