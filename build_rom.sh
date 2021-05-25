# sync rom
repo init --depth=1 -u git://github.com/SpiceOS/android.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/himanshu0218/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_surya-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
breakfast surya
mka bacon

#if you are a patch user (which is really not normal and not recommended), then must put like this, `m aex || repo forall -c 'git checkout .'

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/surya/*UNOFFICIAL*.zip cirrus:surya -P
