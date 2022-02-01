# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/conquerOS/manifest.git -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/LuffyTaro008/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch conquer_rosy-userdebug
make carthage -j$(nproc --all)
