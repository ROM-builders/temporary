# sync rom
repo init --depth=1 -u git://github.com/Havoc-OS/android_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/boedhack/local_manifest.git --depth=1 -b havoc .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
<<<<<<< HEAD
. build/envsetup.sh
lunch havoc_mojito-userdebug
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
export SELINUX_IGNORE_NEVERALLOWS=true
# if you are a patch user, then dont remove the \ and next line , it helps patch users to get sync propely next time
brunch mojito \
	&& repo forall -c 'git checkout .' || repo forall -c 'git checkout .'

# upload rom
# If you need to upload json/multiple files too then put like this
#rclone copy out/target/product/mido/*.zip cirrus:mido -P
#rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/mojito/*.zip cirrus:mojito -P
