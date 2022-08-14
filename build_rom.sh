# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RiceDroid/android -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/NFS-project/local_manifest --depth 1 -b 12.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export TZ=Asia/Jakarta
export KBUILD_BUILD_USER=rosy
export KBUILD_BUILD_HOST=nfsproject
export BUILD_USERNAME=rosy
export BUILD_HOSTNAME=nfsproject
brunch lineage_rosy-userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
