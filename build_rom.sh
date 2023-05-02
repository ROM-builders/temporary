
# ROM de sincronização
repo init -u https://github.com/omnirom/android.git -b android-13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/dudu2504/Vayu/blob/d2265ae6a9cd01210a9d94f967506d00eaaafe4b/local_manifest.xml --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#rom de compilação
source build/envsetup.sh
almoço derp_vayu-user
export TZ=Asia/Dhaka # coloque antes do último comando de compilação
mka derp
# upload rom (se você não precisa fazer upload de vários arquivos, não precisa editar a próxima linha)
rclone copy out/target/product/ $( grep unch $CIRRUS_WORKING_DIR /build_rom.sh -m 1 | cut -d '  ' -f 2 | cut -d _ -f 2 | cut -d - -f 1 ) / * . zip cirrus: $( grep unch $CIRRUS_WORKING_DIR /build_rom.sh -m 1 | corte -d '  ' -f 2 | corte -d _ -f 2 | corte -d - -f 1 ) -P

