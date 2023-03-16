# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android -b 13.0 --git-lfs
git clone https://github.com/trying122/local_manifest --depth 1 -b face .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
  
# build rom
source build/envsetup.sh
lunch lineage_beryllium-userdebug
export BUILD_USERNAME=trying122
export TZ=Asia/Delhi #put before last build command
mka bacon
 
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
