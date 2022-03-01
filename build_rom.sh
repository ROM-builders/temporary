# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/syberia-project/manifest.git -b 12.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/julival25/local&manifest.git --depth 1 -b syberia .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#17

# build rom
source build/envsetup.sh
lunch syberia_tulip-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=America/Sao_Paulo #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
