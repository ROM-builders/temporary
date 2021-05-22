#Sync ROM
repo init --depth=1 -u https://github.com/Wave-Project/manifest -b r -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/yashlearnpython/local_manifest.git --depth=1 -b wave-os .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Apply Patch
#cd device/xiaomi/msm8937-common && curl -LO https://raw.githubusercontent.com/MinatiScape/scripts/main/selinux.patch && git am selinux.patch && cd ../../..
# Build ROM
. build/envsetup.sh
lunch wave_mido-user
mka bacon -j$(nproc --all)

# Upload build
rclone copy out/target/product/tiare/*.zip cirrus:mido -P
