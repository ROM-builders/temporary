# sync rom
repo init --depth=1 --no-repo-verify -u  https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/Roynas-Android-Playground/local_manifests --depth=1 -b Exynos7885-fourteen .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true
export BUILD_BROKEN_DUP_RULES=true
xport BUILD_USER=EliasOfWaffle
export BUILD_USERNAME=EliasOfWaffle
export KBUILD_BUILD_USER=EliasOfWaffle
export TZ=America/Sao_Paulo
brunch a10 eng
#export TZ=America/Sao_Paulo #put before last build command

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
