#!/bin/bash
rm -rf /tmp/rom
mkdir -p /tmp/rom
cd tmp/rom

df -h 


repo init --depth=1 -u https://github.com/Project-Fluid/manifest.git -b fluid-11  || true

    rm -rf .repo/local_manifests || true
     git clone https://github.com/adrian-8901/.repo-local_manifest.git --depth 1 -b fluid .repo/local_manifests
     repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
     source build/envsetup.sh
     lunch fluid_umi-userdebug
     mka bacon -j$(nproc --all)
    ccache -s
    up() {
      curl --upload-file $1 https://transfer.sh/$(basename $1); echo
      # 14 days, 10 GB limit
    }

    up out/target/product/umi/*.zip
