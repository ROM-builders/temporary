# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault

git clone https://gitlab.com/R9Lab/Manifest.git --depth 1 -b LineageOS-12.1 .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom

source build/envsetup.sh

lunch lineage_lava-userdebug

export TZ=Asia/Dhaka #put before last build command

brunch lava

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)

rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut 
