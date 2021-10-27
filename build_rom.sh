# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/jhonnytech90/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
cd /home/cirrus/roms/lineage/device
mkdir -p asus
cd asus
git clone https://github.com/jhonnytech90/device_asus_A001D -b main
mv device_asus_A001D A001D

cd /home/cirrus/roms/lineage/vendor
mkdir -p asus
git clone https://github.com/jhonnytech90/vendor_asus_A001D -b main
mv vendor_asus_A001D A001D
cd /home/cirrus/roms/lineage/kernel
mkdir -p asus
git clone https://github.com/jhonnytech90/kernel_asus_A001D -b main
mv kernel_asus_A001D A001D
cd /home/cirrus/roms/lineage/kernel/A001D
git clone https://github.com/jhonnytech90/kernel_asus_A001D -b main
mv kernel_asus_A001D msm-3.18
cd /home/cirrus/roms/lineage

# build rom
source build/envsetup.sh
lunch lineage_A001D-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
