set -e
set -x

# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/xdroid-oss/xd_manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/Sohang85/Local_Manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync

# build rom
. build/envsetup.sh
lunch xdroid_whyred-userdebug
make xd 

# upload rom
up(){
	curl -sL https://git.io/file-transfer | sh
	./transfer wet *.zip
	# 14 days, 10 GB limit
}

up out/target/product/whyred/*.zip
