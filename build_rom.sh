
#!/bin/bash

set -e
set -x


# sync rom
#repo init -u https://github.com/PixelExperience/manifest --depth=1 -b eleven

#git clone https://github.com/P-Salik/local_manifest --depth=1 -b main .repo/local_manifests

#repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
chmod -R 660 out/target/product/RMX1941/
mka bacon -j$(nproc --all)

# upload
#up(){
#        curl --upload-file $1 https://transfer.sh/$(basename $1); echo
#        # 14 days, 10 GB limit
#}

#up out/target/product/RMX1941/*.zip
