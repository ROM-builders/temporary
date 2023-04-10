# sync rom
repo init -u https://github.com/LineageOS/android.git -b lineage-20.0 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/xiaomi-mt6781-devs/local_manifests.git --depth 1 -b tiramisu .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_viva-user
export WITH_GAPPS=true 
export DEVICE_MAINTAINERS=Rom\ Bdr.\ stuepz
export TZ=Asia/Dhaka #put before last build command
mka bacon



# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/viva/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
