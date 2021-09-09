# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-15.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/dimas-ady/local_manifest.git --depth 1 -b lineage-15.1-microg .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
cd frameworks/base
git fetch "https://gerrit.omnirom.org/android_frameworks_base" refs/changes/29/36729/4 && git cherry-pick FETCH_HEAD
pushd ../../packages/apps/PermissionController # for LineageOS, location may vary for different ROMs
git fetch "https://gerrit.omnirom.org/android_packages_apps_PackageInstaller" refs/changes/30/36730/3 && git cherry-pick FETCH_HEAD
wget https://github.com/microg/android_packages_apps_GmsCore/raw/master/patches/android_frameworks_base-O.patch
patch -p1 < android_frameworks_base-P.patch
source build/envsetup.sh
lunch lineage-userdebug
export TZ=Asia/Jakarta #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
