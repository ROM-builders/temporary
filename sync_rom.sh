#!/bin/bash

set -exv

repo_init () {
	repo init -q --no-repo-verify --depth=1 -u git://github.com/XOSP-Reborn/manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
}

repo_sync () {
  repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
}

clone_dependencies () {
  git clone https://github.com/sasukeuchiha-clan/redmi_begonia -b soni device/redmi/begonia --depth 1
  git clone https://github.com/PotatoDevices/vendor_redmi_begonia vendor/redmi/begonia --depth 1
  git clone https://github.com/PotatoDevices/vendor_redmi_begonia-firmware vendor/redmi/begonia-firmware --depth 1
  git clone https://github.com/ZyCromerZ/begonia -b 20210205/main-ALMK2 kernel/xiaomi/mt6785 --depth 1
  git clone https://github.com/PotatoDevices/vendor_mediatek_opensource vendor/mediatek/opensource --depth 1
  git clone https://github.com/PotatoDevices/vendor_mediatek_interfaces vendor/mediatek/interfaces --depth 1
  git clone https://github.com/Descendant-Devices/vendor_mediatek_ims vendor/mediatek/ims --depth 1
  git clone https://github.com/PotatoProject/device_mediatek_sepolicy -b dumaloo-release device/mediatek/sepolicy --depth 1
}

repo_init
repo_sync
clone_dependencies

