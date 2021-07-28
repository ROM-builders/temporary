# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b cm-14.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/aryankaran/Intex_Cloud_Q11.git --depth 1 -b master .repo/local_manifests
repo sync -c -j30 --force-sync --no-clone-bundle --no-tags || repo sync -c -j`expr 2 \* $(nproc --all)` --force-sync --no-clone-bundle --no-tags
# Apply patches
cd device/intex/Cloud_Q11/patches
bash apply-patches.sh
cd ../../../..

# build rom
source build/envsetup.sh
export USE_CCACHE=1
export TZ=Asia/Kolkata #put before last build command
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4096m"

./prebuilts/sdk/tools/jack-admin kill-server

./prebuilts/sdk/tools/jack-admin start-server

export LC_ALL=C

brunch Cloud_Q11

# upload rom
export location="$(pwd)/out/target/product/Cloud_Q11/*Q11*.zip"
curl --upload-file $location https://transfer.sh/$(basename $location)
