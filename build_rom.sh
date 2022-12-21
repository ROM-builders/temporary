# THIS BUILD IS MEANT FOR PERSONAL USE. Anything I included here are all properly credited.
# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/xdroid-oss/xd_manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
# (DT made by hsx02.. I will make my own soon.)
git clone https://github.com/nullprjkt/local_manifest.git --depth 1 -b xd-spes .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch xdroid_spes-userdebug
export TZ=Asia/Ho_Chi_Minh #put before last build command
mka xd

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
