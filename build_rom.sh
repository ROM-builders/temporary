# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-19.1 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/CEKIKOFGAMERS/local_manifest.git --depth 1 -b lineage_moonstone .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_moonstone-userdebug
export BUILD_USERNAME=Kristoforusapm
export BUILD_HOSTNAME=SingkoLab
export KBUILD_USERNAME=Kristoforusapm
export KBUILD_HOSTNAME=SingkoLab
export TZ=Asia/Jakarta
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE=true
m bacon -j8

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
