repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-mips,-darwin,-notdefault
git clone https://gitlab.com/divested-mobile/divestos-build.git;
repo init -u https://github.com/LineageOS/android.git -b lineage-18.1;
git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

repo init -u https://github.com/LineageOS/android.git -b lineage-18.1;
# build rom
source build/envsetup.sh
lunch derp_vayu-user
export TZ=Asia/Dhaka #put before last build command
lunch divestos_vayu-user
export TZ=Asia/jaipur #put before last build command
mka deuvestos

