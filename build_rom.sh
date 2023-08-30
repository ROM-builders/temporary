# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RisingTechOSS/android -b thirteen --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/Rinto02/Local-Manifest.git --depth 1 -b rising .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export KBUILD_BUILD_USER=rinto
export KBUILD_BUILD_HOST=rinto
export BUILD_USERNAME=rinto
export BUILD_HOSTNAME=rinto
export TZ=Asia/Dhaka #put before last build command
brunch RMX2020 user 
 
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
