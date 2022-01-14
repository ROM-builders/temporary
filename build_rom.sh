# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Xtended/manifest.git -b wip -g default,-mips,-darwin,-notdefault
git clone https://github.com/TelkomFlexi/local_manifest --depth 1 -b Gatau .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j12

# build rom
source build/envsetup.sh
lunch xtended_ginkgo-userdebug
export BUILD_USERNAME=Zephyrus
export BUILD_HOSTNAME=Zephyrus
export TZ=Asia/Jakarta
export ALLOW_MISSING_DEPENDENCIES=true
make xtended

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
