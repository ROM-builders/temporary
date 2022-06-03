# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/AospExtended/manifest.git -b 12.1.x -g default,-mips,-darwin,-notdefault
git clone https://github.com/ibraaltabian17/local_manifest.git --depth 1 -b proton .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom arroew
source build/envsetup.sh
lunch aosp_beryllium-userdebug
BUILD_USER="Ibratabian17"
BUILD_HOST="Prjktla"
BUILD_USERNAME="Ibratabian17"
BUILD_HOSTNAME="Prjktla"
export TZ=Asia/Jakarta #put before last build command
croot
export BUILD_USER="Ibratabian17"
export BUILD_HOST="Prjktla"
m aex

#14 Update Sourcw
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
