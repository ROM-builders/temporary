# sync rom
repo init --depth=1 --no-repo-verify -u repo init --depth=1 -u https://github.com/Sakura-Revived/android.git -b 11 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/L1ghtzin/local_manifest --depth 1 -b eleven .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_channel-user
export TZ=America/Sao_Paulo #put before last build command
m bacon -j32

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
