# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest.git -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/Sanju0910/local_manifest.git --depth 1 -b main .repo/local_manifests 
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_vayu-userdebug
export TZ=Asia/Kolkata #put before last build command
mka evolution

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/avicii/*.zip
up out/target/product/avicii/recovery.img 
