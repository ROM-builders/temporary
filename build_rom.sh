# sync rom
repo init -u https://github.com/NusantaraProject-ROM/android_manifest.git -b 11 --groups=all,-notdefault,-darwin,-mips,-device --depth=1
git clone https://github.com/hadad/local_manifest.git .repo/local_manifests --depth=1
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch nad_onclite-userdebug
mka nad -j$(nproc --all)
#if you are a patch user (which is really not normal and not recommended), then must put like this, `m aex || repo forall -c 'git checkout .'

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/onclite/Nusantara_v2.9-11-onclite*.zip cirrus:onclite -P
