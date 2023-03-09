# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/baconpeedit/Local_Manifest.git --depth 1 -b evolution .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch evolution_ginkgo-userdebug
export BUILD_USERNAME=Tejas
export BUILD_HOSTNAME=I_Am_Charsi
export KBUILD_BUILD_USER=Tejas
export KBUILD_BUILD_HOST=I_Am_Charsi
export TZ=Asia/Kolkata
mka evolution
cat o*/t*/p*/ginkgo/*.zip.json

# upload rom
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
