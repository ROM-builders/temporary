cd ~/
git clone https://github.com/akhilnarang/scripts
cd scripts
./setup/android_build_env.sh
mkdir -p ~/bin
mkdir -p ~/android/pe
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.email "81231195+LittleChest@users.noreply.github.com"
git config --global user.name "LittleChest"
cd ~/android/pe
repo init -u https://github.com/PixelExperience/manifest -b twelve-plus
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
cd ~/android/pe
source build/envsetup.sh
lunch aosp_vangogh-userdebug
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 50G
croot
mka bacon -j$(nproc --all)
cd $OUT
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
pwd
ls $OUT
ls /*
