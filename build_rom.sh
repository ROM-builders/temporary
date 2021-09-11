# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Project-LegionOS/manifest.git -b 11  -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/muhammad23012009/local_manifests -b aosp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_hannah-user
export TZ=Asia/Dhaka #put before last build command
mka bacon -j24

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/hannah/*.zip
