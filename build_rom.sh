# sync rom
repo init -u https://github.com/Project-Fluid/manifest.git -b fluid-11 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/RMX1805/device_oppo_RMX1805 -b lineage-18.1 device/oppo/RMX1805 && git clone https://github.com/RMX1805/vendor_oppo -b lineage-18.1 vendor/oppo

repo sync --force-sync --no-tags --no-clone-bundle -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch fluid_RMX1805-userdebug
mka bacon 

# upload rom
rclone copy out/target/product/RMX1805/*UNOFFICIAL*.zip cirrus:RMX1805 -P
