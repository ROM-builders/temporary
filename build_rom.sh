# sync rom
repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-18.1
git clone https://github.com/phhusson/treble_manifest .repo/local_manifests  -b android-11.0
repo sync -c -j4 --force-sync --no-tags --no-clone-bundle
git clone https://github.com/phhusson/treble_patches -b android-11.0
git am patch

# build rom
. build/envsetup.sh
lunch treble_arm64_avN-userdebug
WITHOUT_CHECK_API=true make -j8 systemimage

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/../../*.img cirrus:mido -P
