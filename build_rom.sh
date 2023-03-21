# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-18.1 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/Fr0ztyy43/local_manifests.git --depth 1 -b cr11 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rommhhdbvbvdasaad
source build/envsetup.sh
lunch lineage_begonia-userdebug

export KBUILD_BUILD_USER=Fr0ztyy43 
export KBUILD_BUILD_HOST=Fr0ztyy43
export BUILD_USERNAME=Fr0ztyy43 
export BUILD_HOSTNAME=Fr0ztyy43 

export TZ=Asia/Dhaka #put before last build command
mka bacon


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
