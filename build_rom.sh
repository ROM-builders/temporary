# sync rom
repo init --depth=1 --no-repo-verify -u  git://github.com/Evolution-X/manifest -b elle -g default,-device,-mips,-darwin,-notdefault

vim .repo/local_manifests/roomservice.xml
<?xml version="1.0" encoding="UTF-8"?>
  <manifest>
      <!-- SONY -->
      <project name="fazrul1994/android_kernel_sony_msm8998" path="kernel/sony/msm8998" remote="github" revision="lineage-18.1" />
      <project name="fazrul1994/android_device_sony_yoshino-common" path="device/sony/yoshino-common" remote="github" revision="lineage-18.1" />
      <project name="fazrul1994/android_device_sony_poplar" path="device/sony/poplar" remote="github" revision="lineage-18.1" />

      <!-- Pinned blobs for poplar -->
      <project name="fazrul1994/android_vendor_sony_poplar" path="vendor/sony/poplar" remote="github" revision="lineage-18.1" />
  </manifest>

git clone https://github.com/fazrul1994/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch evolution_poplar-userdebug
export TZ=Asia/Jakarta #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
