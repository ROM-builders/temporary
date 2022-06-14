# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/DotOS/manifest.git -b dot12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/VR-HoangLong/LocalManifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
cd device/phh/treble
bash generate.sh dot.mk
cd ../../..

source build/envsetup.sh
lunch treble_arm64_bvN-userdebug
export TZ=Asia/Ho_Chi_Minh #put before last build command
make systemimage

zip $OUT/DotOS.zip files -x "$OUT/system.img"

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
