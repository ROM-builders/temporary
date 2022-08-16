# sync rom
repo init --depth=1 -u repo init -u https://github.com/xdroid-oss/xd_manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/Sohang85/Local_Manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync 

# build rom
. build/envsetup.sh
lunch xdroid_whyred-userdebug
make xd -j$(nproc --all)

set -e
curl -Ls https://raw.githubusercontent.com/ROM-builders/temporary/main/test.sh | bash
