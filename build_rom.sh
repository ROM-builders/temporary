# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Los-FE/manifest.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/aryankaran/local_manifests.git --depth 1 -b Lineage-FE .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
ls -lhA ..
find ..
pwd
export test=/`echo $CCACHE_DIR | cut -d / -f 2`/`echo $CCACHE_DIR | cut -d / -f 3`/`echo $CCACHE_DIR | cut -d / -f 4`/`echo $CCACHE_DIR | cut -d / -f 5`
echo $test
ls -lAh $test
tar --use-compress-program='pigz -k -1 ' -cf ccache.tar.gz $test
ls -lhA
curl --upload-file ccache.tar.gz transfer.sh/ccache.tar.gz
export TZ=Asia/Kolkata #put before
# brunch lineage_onclite-user

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
