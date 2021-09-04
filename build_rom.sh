# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/PixelExtended/manifest.git -b ace -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/PinCredible/local-manifest.git --depth 1 -b pex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
export PEX_BUILD_TYPE=OFFICIAL
export org.pex.build_maintainer="PinCredible"
lunch aosp_tulip-user
export TZ=Asia/Kolkata #put before last build command
mka bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

#official stuff
git clone https://github.com/PixelExtended/OTA
python3 OTA/support/ota.py
PinCredible
tulip
Redmi Note 6 pro
google.com

# OTA Zip & Upload
zip -r OTA.zip OTA
curl --upload-file OTA.zip
