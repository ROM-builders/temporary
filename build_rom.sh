# sync rom
repo init --depth=1 -u https://github.com/SpiceOS/android.git -b 11
git clone https://github.com/Dreadwyrm/local_manifests.git --depth 1 -b main .repo/local_manifests

# patches
cd frameworks/av
git fetch https://github.com/Evolution-X/frameworks_av 1e49c16e071194dff66b7fdb24e41f2dc942c6b9 && git cherry-pick FETCH_HEAD
git fetch https://github.com/Evolution-X/frameworks_av ae552c0fd8c7f9816dda3c81f9f00bc3c237e292 && git cherry-pick FETCH_HEAD

# build rom
. build/envsetup.sh
breakfast ginkgo
export TZ=Asia/Jakarta
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
