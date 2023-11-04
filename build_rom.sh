# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/DerpFest-12/manifest.git -b 12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/JV007xp/local_manifest --depth 1 -b derp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom #2
source build/envsetup.sh
lunch derp_A001D-userdebug
export TZ=America/Sao_Paulo
export ALLOW_MISSING_DEPENDENCIES=true
export KBUILD_BUILD_USER=jv007xp
export KBUILD_BUILD_HOST=jv007xp
export BUILD_USERNAME=jv007xp
export BUILD_HOSTNAME=jv007xp
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

