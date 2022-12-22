# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Awaken/android_manifest -b triton -g default,-mips,-darwin,-notdefault
git clone https://github.com/j0ok34n/local_manifestw.git --depth 1 -b awaken-13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
cp packages/apps/Settings/res/values/awaken_strings.xml ../awaken_strings.xml
perl -pe 's/Unofficial Maintainer/"Công Vĩnh"/g' ../awaken_strings.xml > packages/apps/Settings/res/values/awaken_strings.xml
export TZ=Asia/Ho_Chi_Minh
lunch awaken_miatoll-userdebug
make bacon
# re-run
perl -pe 's/"Công Vĩnh"/Unofficial Maintainer/g' ../awaken_strings.xml > packages/apps/Settings/res/values/awaken_strings.xml
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
