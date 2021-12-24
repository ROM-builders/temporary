 # sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Xtended/manifest.git -b xs -g default,-mips,-darwin,-notdefault
git clone https://github.com/K-fear/Local-Manifests.git --depth 1 -b xtended_mido .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch xtended_mido-userdebug
export PRODUCT_OUT
export HOST_OUT
export PRODUCT_OUT
export HOST_OUT_TESTCASES
export PRODUCT_OUT_TESTCASES
export TZ=Asia/Jakarta #put before last build command
make xtended
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
