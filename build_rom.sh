# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/crdroidandroid/android.git -b 11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/D34DPUL/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export TZ=Asia/Kolkata #put before last build command
brunch lineage_liber-userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
#rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
rclone copy out/target/product/liber/boot.img cirrus:liber/cr -P 
rclone copy out/target/product/liber/dtbo.img cirrus:liber/cr -P 
rclone copy out/target/product/liber/system.img cirrus:liber/cr -P 
rclone copy out/target/product/liber/product.img cirrus:liber/cr -P 
rclone copy out/target/product/liber/vbmeta.img cirrus:liber/cr -P 
rclone copy out/target/product/liber/vendor.img cirrus:liber/cr -P 
