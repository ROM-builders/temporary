repo init --git-lfs --no-repo-verify -u https://github.com/syberia-project/manifest.git -b 13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/GunaisHere/local_manifests.git --depth 1 -b 13 .repo/local_manifests
repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) --optimized-fetch --prune
# build rom
source build/envsetup.sh
lunch miatoll-release
export BUILD_USERNAME=GL_Founder
export TZ=Asia/Dhaka #put before last build command
m projectsyberia

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
