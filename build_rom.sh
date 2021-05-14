# sync rom
repo init --depth=1 -u https://github.com/Corvus-R/android_manifest.git -b 11
git clone https://github.com/jrchintu/local_manifest.git --depth 1 -b corvus .repo/local_manifests
repo sync -j$(nproc --all) --force-sync --no-tags --no-clone-bundle

# Set up environment
. build/envsetup.sh

# Choose a target
lunch corvus_device-userdebug

# Build the ROM
make corvus

# upload rom
rclone copy out/target/product/mido/*.zip cirrus:mido -P
