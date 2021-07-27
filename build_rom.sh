# sync rom
repo init -u git://github.com/crdroidandroid/android.git -b 11.0
git clone https://github.com/D34DPUL/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export TZ=Asia/Kolkata #put before last build command
brunch lineage_liber-userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/liber/boot.img cirrus:liber/cr -P && rclone copy out/target/product/liber/dtbo.img cirrus:liber/cr -P && rclone copy out/target/product/liber/system.img cirrus:liber/cr -P && rclone copy out/target/product/liber/product.img cirrus:liber/cr -P && rclone copy out/target/product/liber/vbmeta.img cirrus:liber/cr -P && rclone copy out/target/product/liber/vendor.img cirrus:liber/cr -P 
