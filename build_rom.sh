# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/BlissRoms/platform_manifest.git -b r -g default,-mips,-darwin,-notdefault
git clone https://github.com/JV007xp/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) --optimized-fetch --prune

# build rom
 . build/envsetup.sh
 blissify options A001D
export TZ=America/Sao_Paulo
export ALLOW_MISSING_DEPENDENCIES=true
export SELINUX_IGNORE_NEVERALLOWS=true
brunch blissify_A001D-userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

blissify -g A001D
