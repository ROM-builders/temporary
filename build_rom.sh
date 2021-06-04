# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/NusantaraProject-ROM/android_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/Fraschze97/local_manifest --depth=1 -b nusantara .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch nad_RMX1941-userdebug
export USE_GAPPS=true
export TZ=Asia/Jakarta

# metalava
make_metalava(){
	make sepolicy
	make init
	make booimage
}

make_metalava
mka nad


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
