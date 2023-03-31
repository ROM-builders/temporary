# sync rom
repo init -u https://github.com/PixysOS/manifest -b thirteen
repo sync -c -j8 --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch pixys_fog-userdebug
make pixys
