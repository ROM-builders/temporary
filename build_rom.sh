#Making Directory
mkdir yograj
cd yograj

#Initialising repo for rom [Can get from Project page on github]
repo init -u https://github.com/Corvus-R/android_manifest.git -b 11

#local_manifest
git clone https://github.com/yograjsingh-cmd/local_manifest.git -b main .repo/local_manifests

#Repo Sync
repo sync -j$(nproc --all) --force-sync --no-tags --no-clone-bundle --prune

#Cloning Device tree [make device tree compatible for your rom]
#git clone https://github.com/yograjsingh-cmd/android_device_asus_Z01R-2.git -b derp device/asus/Z01R
#cd device/asus/Z01R && git pull && cd ../../..

#Cloning Kernel
#git clone https://github.com/yograjsingh-cmd/kernel_z01r.git -b eleven kernel/asus/sdm845
#cd kernel/asus/sdm845 && git pull && cd ../../..

#Cloning Vendor
#git clone https://github.com/yograjsingh-cmd/vendor_asus.git -b lineage-18.1 vendor/asus
#cd vendor/asus && git pull && cd ../..

# build rom
. build/envsetup.sh
lunch corvus_Z01R-userdebug
export TZ=Asia/Kolkata #put before last build command (setting timezone)
make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
