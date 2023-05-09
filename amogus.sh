#!/usr/bin/env bash

MOTO_COMMON="https://github.com/moto-common"
AOSPA="https://github.com/AOSPA"
AOSPA_VN="https://github.com/ThankYouMario"

# Device Trees
git clone ${MOTO_COMMON}/android_device_motorola_common -b 13 device/motorola/common
git clone ${MOTO_COMMON}/android_device_motorola_targets -b master device/motorola/targets

# SM6125 (4.14)
git clone ${MOTO_COMMON}/android_kernel_motorola_msm-4.14 -b 13 kernel/motorola/msm-4.14
git clone ${MOTO_COMMON}/android_device_motorola_amogus-kernel -b 13 device/motorola/amogus-kernel
git clone ${MOTO_COMMON}/android_device_motorola_amogus -b 13 device/motorola/amogus

# Vendor Trees
git clone ${MOTO_COMMON}/android_vendor_motorola_common -b 13 vendor/motorola/common
git clone ${MOTO_COMMON}/android_vendor_motorola_amogus -b 13 vendor/motorola/amogus

# QCOM Common
"$(rm -rf device/qcom/common vendor/qcom/common)"
git clone ${AOSPA}/android_device_qcom_common -b topaz device/qcom/common
git clone ${AOSPA_VN}/proprietary_vendor_qcom_common -b topaz vendor/qcom/common

# HALs
"$(rm -rf vendor/qcom/opensource/audio/sm8150 vendor/qcom/opensource/display/sm8150 vendor/qcom/opensource/display-commonsys-intf)"
"$(rm -rf vendor/qcom/opensource/media/sm8150 vendor/qcom/opensource/vibrator)"
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_audio_sm8150 -b master vendor/qcom/opensource/audio/sm8150
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_display_sm8150 -b master vendor/qcom/opensource/display/sm8150
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_display-commonsys-intf -b master vendor/qcom/opensource/display-commonsys-intf
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_media_sm8150 -b master vendor/qcom/opensource/media/sm8150
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_vibrator -b 13 vendor/qcom/opensource/vibrator

# Clear
"$(rm -rf device/qcom/qssi)"
"$(rm -rf device/qcom/sepolicy_vndr )"
"$(rm -rf device/qcom/sepolicy )"
"$(rm -rf device/sony/sepolicy)"
"$(rm -rf external/fastrpc)"
"$(rm -rf prebuilts/clang/host/linux-x86/clang-r383902)"
"$(rm -rf vendor/goodix)"
"$(rm -rf vendor/qcom/opensource/thermal-engine)"
"$(rm -rf vendor/qcom/opensource/thermal)"
"$(rm -rf vendor/qcom/opensource/interfaces)"
"$(rm -rf vendor/qcom/opensource/fwk-detect)"
"$(rm -rf vendor/qcom/opensource/dataservices)"
"$(rm -rf vendor/qcom/opensource/data-ipa-cfg-mgr-legacy)"
"$(rm -rf vendor/qcom/opensource/audio/st-hal)"
"$(rm -rf external/json-c)"
"$(rm -rf external/ant-wireless/hidl)"
"$(rm -rf system/qcom)"
"$(rm -rf vendor/codeaurora/telephony)"
"$(rm -rf hardware/motorola)"
"$(rm -rf vendor/sony/timekeep)"

# Misc
git clone ${AOSPA}/android_device_qcom_qssi -b topaz device/qcom/qssi
git clone ${AOSPA}/android_device_qcom_sepolicy_vndr -b topaz device/qcom/sepolicy_vndr
git clone ${AOSPA}/android_device_qcom_sepolicy -b topaz device/qcom/sepolicy
git clone ${AOSPA}/android_external_fastrpc -b topaz external/fastrpc
git clone ${MOTO_COMMON}/platform_prebuilts_clang_host_linux-x86_clang-r383902 -b master prebuilts/clang/host/linux-x86/clang-r383902
git clone ${MOTO_COMMON}/platform_vendor_goodix -b master vendor/goodix
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_thermal-engine -b 12 vendor/qcom/opensource/thermal-engine
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_thermal -b master vendor/qcom/opensource/thermal
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_interfaces -b master vendor/qcom/opensource/interfaces
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_fwk-detect -b 12 vendor/qcom/opensource/fwk-detect
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_dataservices -b master vendor/qcom/opensource/dataservices
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_data-ipa-cfg-mgr-legacy-um -b master vendor/qcom/opensource/data-ipa-cfg-mgr-legacy
git clone ${MOTO_COMMON}/platform_vendor_qcom_opensource_audio_st-hal -b 13 vendor/qcom/opensource/audio/st-hal
git clone ${MOTO_COMMON}/platform_external_json-c -b 13 external/json-c
git clone ${MOTO_COMMON}/external_ant-wireless_hidl -b master external/ant-wireless/hidl
git clone ${MOTO_COMMON}/android_system_qcom -b master system/qcom
git clone ${MOTO_COMMON}/platform_vendor_codeaurora_telephony -b 13 vendor/codeaurora/telephony
git clone ${MOTO_COMMON}/android_hardware_motorola -b 13 hardware/motorola
git clone ${MOTO_COMMON}/android_vendor_sony_timekeep -b 12 vendor/sony/timekeep