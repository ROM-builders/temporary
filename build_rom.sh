wget https://raw.githubusercontent.com/akhilnarang/scripts/master/setup/android_build_env.sh
. android_build_env.sh
git config --global user.name "Rishik"
git config --global user.email "xxrishikcootr@gmail.com"

# sync rom
repo init --depth=1 -u https://github.com/SuperiorOS/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/samsungexynos9810/local_manifests-V2 -b main .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_star2lte-userdebug
export TZ=Asia/Dhaka 
#put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
