# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Evolution-X/manifest.git -b snow -g default,-mips,-darwin,-notdefault
git clone https://github.com/Sushrut1101-ROMs/local_manifests.git --depth 1 -b m20lte .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24

# build rom
source build/envsetup.sh
export SKIP_ABI_CHECKS=true
export ALLOW_MISSING_DEPENDENCIES=true # Sorry to use this, but it being used to skip lineage specific errors (for hardware_samsung repo)
lunch evolution_m20lte-userdebug
export TZ=Asia/Kolkata #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

cd out/target/product/m20lte
OUTPUT="evolution*m20lte*.zip"
FILENAME=$(ls $OUTPUT)
curl -sL https://git.io/file-transfer | sudo bash
./transfer wet $FILENAME
cd -
exit 0
