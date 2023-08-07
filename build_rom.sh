# sync rom
repo init --depth=1 -u repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.1-b --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/L1ghtzin/local_manifest --depth 1 -b eleven .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch arrow_devon-user-debug
export TZ=America/Sao_Paulo
m bacon 

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
