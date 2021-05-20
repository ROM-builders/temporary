#!/bin/bash
rom_sources(){
	repo init -u https://github.com/NusantaraProject-ROM/android_manifest.git -b 11 --groups=all,-notdefault,-darwin,-mips,-device --depth=1
	repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
	repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
}

device_sources(){
	git clone https://github.com/NusantaraROM-Devices/device_xiaomi_onclite.git -b 11 device/xiaomi/onclite --depth=1
	git clone https://github.com/NusantaraROM-Devices/kernel_xiaomi_onclite.git -b 11 kernel/xiaomi/onclite --depth=1
	git clone https://github.com/NusantaraROM-Devices/vendor_xiaomi_onclite.git -b 11 vendor/xiaomi/onclite --depth=1
}

build_rom(){
	source build/envsetup.sh
	lunch nad_onclite-userdebug
	mka nad -j$(nproc --all)
}

upload_rom(){
	curl --upload-file out/target/product/onclite/Nusantara_v2.9-11-onclite*.zip https://transfer.sh
}

rom_sources
device_sources
build_rom
upload_rom
