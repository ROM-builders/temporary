# sync rom 
    repo init -u https://github.com/CherishOS/android_manifest.git -b eleven   -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Shazu-xD/local_manifest --depth 1 -b main.repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags


# build rom 
source build/envsetup.sh
brunch RMX1801

# upload rom
rclone copy out/target/product/RMX1801/*.zip cirrus:RMX1801 -P
