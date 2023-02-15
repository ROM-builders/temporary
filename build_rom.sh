repo init --depth=1 --no-repo-verify -u https://github.com/AlphaDroid-Project/manifest -b alpha-13 default,-mips,-darwin,-notdefault
git clone https://github.com/dangi-del/local-manifest.git --depth 1 -b main .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch mido-AlphaDroid-13-dangi
export TZ=Asia/india #put before last build command
WITH_GAPPS:=true
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
