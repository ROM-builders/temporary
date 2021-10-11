# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-17.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/iAboothahir/manifest.git --depth 1 -b lineage-17.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
wget https://raw.githubusercontent.com/iAboothahir/20-20/master/patches/001-fix_error1.patch
cp 001-fix_error1.patch device/Asus/X00TD
cd device/Asus/X00TD
patch -p1 < 001-fix_error1.patch
cd -
# build rom lineage

source build/envsetup.sh

lunch lineage_X00TD-userdebug
export TZ=Asia/Dhaka #put before last build command
brunch X00TD

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
