# sync rom
repo init --depth=1 -u git://github.com/crdroidandroid/android.git -b 11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Realme-G90T-Series/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#patches
git clone https://github.com/sarthakroy2002/clang-r353983c1 prebuilts/clang/host/linux-x86/clang-r353983c1
git clone https://github.com/PixelExperience/vendor_mediatek_ims.git vendor/mediatek/ims
git clone https://github.com/PixelExperience/vendor_mediatek_interfaces.git vendor/mediatek/interfaces
git clone https://github.com/HyperTeam/android_packages_apps_RealmeParts packages/apps/RealmeParts

cd external/selinux
curl -L http://ix.io/2FhM > sasta.patch
git am sasta.patch
cd -
cd frameworks/av
wget https://github.com/phhusson/platform_frameworks_av/commit/624cfc90b8bedb024f289772960f3cd7072fa940.patch
patch -p1 < *.patch
cd -

# build rom
source build/envsetup.sh
lunch lineage_RMX2001-userdebug
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
mka bacon

# upload rom
device=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1)
rclone copy out/target/product/RMX2001/crdroidandroid*.zip cirrus:$device -P
