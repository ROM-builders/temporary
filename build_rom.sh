# sync rom
repo init --depth=1 --no-repo-verify -u git://codeaurora.org/platform/manifest.git -b release -m LA.UM.9.6.2.c25-01800-89xx.0 --repo-url=git://codeaurora.org/tools/repo.git --repo-branch=caf-stable -g default,-mips,-darwin,-notdefault
git clone https://github.com/Guilherme2041/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_A001D-userdebug
export TZ=America/Sao_Paulo
mka bacon -j8

# upload rom
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
