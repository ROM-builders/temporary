# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u https://github.com/bananadroid/android_manifest.git -b 13 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/stuepz/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
source build/envsetup.sh
lunch banana_viva-userdebug
export TZ=Asia/Dhaka #put before last build command
m banana

up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/viva/*.zip
