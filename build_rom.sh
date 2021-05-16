# sync rom 
repo init -u git://github.com/TenX-OS/manifest_TenX -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/thebuildbomt/local_manifest --depth 1 -b los .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags


# build rom pe
source build/envsetup.sh
lunch aosp_RMX1801-userdebug
brunch RMX1801

# upload rom
rclone copy out/target/product/RMX1801/aosp*RMX1801.zip cirrus:RMX1801 -P
