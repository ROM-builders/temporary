#!/usr/bin/env bash

echo '- set build flag variables.'
export CCACHE_DIR=/tmp/cache
export CCACHE_EXEC=/usr/bin/ccache
export RELAX_USES_LIBRARY_CHECK=true
export RELEASE_TYPE=AMOGUS
export TARGET_INCLUDE_GBOARD=true
export TARGET_INCLUDE_LAWNCHAIR=true
export TARGET_REMOVE_PACKAGE=true
export TZ=Antarctica/South_Pole
export USE_CCACHE=1
export WITH_GMS=true

echo '- change current directory to lineage directory.'
cd "$HOME/lineage" || exit

echo '- initialize source repository.'
repo init -u https://github.com/LineageOS/android.git -b lineage-19.1

echo '- download the source code.'
repo sync -j12

echo '- reset modifications.'
for path in "vendor/cm" "vendor/lineage" "frameworks/base" "packages/apps/PermissionController" "packages/modules/Permission"; do
    if [ -d "$path" ]; then
        cd "$path" || exit
        git reset -q --hard
        git clean -q -fd
        cd "$HOME/lineage" || exit
    fi
done

echo 'make folder named local_manifests with custom repository.'
mkdir -p .repo/local_manifests
echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<manifest>\n    <project path=\"vendor/partner_gms\" name=\"flame-0/android_vendor_prebuilt\" remote=\"github\" revision=\"phonesky-patched\"/>\n</manifest>" >> .repo/local_manifests/amogus.xml

echo '- remove trebuchet launcher and trebuchet overlay.'
sed -i -z 's/\nifeq ($(PRODUCT_TYPE), go)\nPRODUCT_PACKAGES += \\\n    TrebuchetQuickStepGo\n\nPRODUCT_DEXPREOPT_SPEED_APPS += \\\n    TrebuchetQuickStepGo\nelse\nPRODUCT_PACKAGES += \\\n    TrebuchetQuickStep\n\nPRODUCT_DEXPREOPT_SPEED_APPS += \\\n    TrebuchetQuickStep\nendif\n//' vendor/lineage/config/common_mobile.mk
sed -i -z 's/\\\n    TrebuchetOverlay//' vendor/lineage/config/common.mk

echo '- setup microg overlay.'
mkdir -p "vendor/lineage/overlay/microg"
sed -i "1s;^;PRODUCT_PACKAGE_OVERLAYS := vendor/lineage/overlay/microg\n;" "vendor/lineage/config/common.mk"

makefile_containing_version="vendor/lineage/config/common.mk"
if [ -f "vendor/lineage/config/version.mk" ]; then
    makefile_containing_version="vendor/lineage/config/version.mk"
fi

echo '- fetch patches'
wget -q -O "$HOME/lineage/patch/android_frameworks_base-R.patch" "https://raw.githubusercontent.com/lineageos4microg/docker-lineage-cicd/master/src/signature_spoofing_patches/android_frameworks_base-R.patch"
wget -q -O "$HOME/lineage/patch/packages_apps_PermissionController-R.patch" "https://raw.githubusercontent.com/lineageos4microg/docker-lineage-cicd/master/src/signature_spoofing_patches/packages_apps_PermissionController-R.patch"
wget -q -O "$HOME/lineage/patch/frameworks_base_config.xml" "https://raw.githubusercontent.com/lineageos4microg/docker-lineage-cicd/master/src/signature_spoofing_patches/frameworks_base_config.xml"

echo '- apply signature spoofing patch.'
cd frameworks/base || exit
patch --quiet --force -p1 -i "$HOME/lineage/patch/android_frameworks_base-R.patch"
git clean -q -f
cd ../../

cd packages/apps/PermissionController || exit
patch --quiet --force -p1 -i "$HOME/lineage/patch/packages_apps_PermissionController-R.patch"
git clean -q -f
cd ../../../

echo '- override settings for location providers.'
mkdir -p "vendor/lineage/overlay/microg/frameworks/base/core/res/res/values"
cp "$HOME/lineage/patch/frameworks_base_config.xml" "vendor/lineage/overlay/microg/frameworks/base/core/res/res/values/config.xml"

echo '- set release type.'
sed -i "/\$(filter .*\$(LINEAGE_BUILDTYPE)/,/endif/d" "$makefile_containing_version"

echo '- set ccache size.'
ccache -M 50G

echo '- setup environment.'
source build/envsetup.sh

echo '- select build target.'
lunch lineage_arm64-eng

echo '- start build.'
mka api-stubs-docs-non-updatable-update-current-api
mka

echo '- export.'
mka sdk_addon

echo '- upload zip.'
rclone copy out/host/linux-x86/sdk_addon/"$(grep unch "$CIRRUS_WORKING_DIR"/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)"/*.zip cirrus:"$(grep unch "$CIRRUS_WORKING_DIR"/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)" -P
