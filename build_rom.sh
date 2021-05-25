#cleanup
make clean && make clobber
# sync rom
repo init --depth=1 -u git://github.com/CipherOS/android_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/RahulPalXDA/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_X00TD-userdebug
mka bacon -j$(nproc --all)
#if you are a patch user (which is really not normal and not recommended), then must put like this, `m aex || repo forall -c 'git checkout .'

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/X00TD/*.zip cirrus:X00TD -P && rclone copy out/target/product/X00TD/*.img cirrus:X00TD -P
