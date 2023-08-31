# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u https://github.com/LineageOS/android.git -b lineage-18.1 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/Nobodyayushhere/local_manifest.git --depth 1 -b main .repo/local_manifests
git clone cd external/selinux && curl -o 0001-Revert-libsepol-Make-an-unknown-permission-an-error-.patch -L https://github.com/Maanush2004/patches/external/selinux/0001-Revert-libsepol-Make-an-unknown-permission-an-error-.patch && git am 0001-Revert-libsepol-Make-an-unknown-permission-an-error-.patch && cd ../..

git clone cd build/make && curl -o 0001-RMX1821-build-Add-option-to-append-vbmeta-image-to-b.patch -L https://github.com/RMX1821-devs/patches/raw/lineage-20.0/build/make/0001-RMX1821-build-Add-option-to-append-vbmeta-image-to-b.patch && git am 0001-RMX1821-build-Add-option-to-append-vbmeta-image-to-b.patch && cd ../..

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_RMX1821-userdebug
export TZ=Asia/Dhaka #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
