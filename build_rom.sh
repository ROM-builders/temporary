# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ricedroidOSS/android.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/emanosi/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# chipset flag enclose var with "" if more than one
# friendly tip: builders can use init_xxx.cpp as workaround for spacing
# e.g. property_override("ro.rice.chipset", "Snapdragon 870 5G");
RICE_CHIPSET := "Helio G80"

# chipset flag enclose var with "" if more than one
# friendly tip: builders can use init_xxx.cpp as workaround for spacing
# e.g. property_override("ro.rice.maintainer", "get riced");
RICE_MAINTAINER := "a emanosi"

# chipset flag enclose var with "" if more than one
# this will reflect on build/display version, a firmware package/zip name 
# e.g. riceDroid-7.0-COMMUNITY-device-AOSP.zip - AOSP is the default package type, WITH_GMS will override the package type to PIXEL
RICE_PACKAGE_TYPE := "WITH_GMS"

# Sushi Bootanimation (only 720/1080p/1440 supported. if not defined, bootanimation is google bootanimation)
SUSHI_BOOTANIMATION := 1080

# Aperture Camera (default: not defined - skipped by the compiler)
TARGET_BUILD_APERTURE_CAMERA := true

# Graphene Camera (default: not defined - skipped by the compiler)
TARGET_BUILD_GRAPHENEOS_CAMERA := false

# disable/enable blur support, default is false
TARGET_ENABLE_BLUR := false

# UDFPS ICONS/ANIMATIONS
TARGET_HAS_UDFPS := true

# Allow usage of custom binary linker (LD), default is false
TARGET_KERNEL_OPTIONAL_LD := false

# Spoof build description/fingerprint as pixel device
TARGET_USE_PIXEL_FINGERPRINT := true

# GMS build flags, if none were defined the package build type will be AOSP (default: false)
WITH_GMS := true - ship with GMS packages, replaces misc AOSP packages with Google packages.

# Customized GMS Flags 
# WITH_GMS flag is required

# Wether to use google (true) or AOSP (false) telephony package bundle. (defaults: false for gms core, true for pixel builds)
TARGET_USE_GOOGLE_TELEPHONY := true

# Compiler will only build GMS playstore services, its dependencies, and Gboard app.
# package type will change from PIXEL/GMS -> CORE
TARGET_CORE_GMS := true

# extra flag under TARGET_CORE_GMS
TARGET_CORE_GMS_EXTRAS := false - extra packages for core build type (velvet and photos)
# Camera

# Exposing aux/camera privileges to OEM cameras
persist.camera.manufacturer=oneplus (oem or certain common word that exists to oem camera package)
persist.camera.oem.package=com.oneplus.camera (actual oem camera package)

# Overriding camera id 
# 1. Add depth sensor flag to device tree makefiles
TARGET_USES_DEPTHSENSOR_OVERRIDE := true

# 2. Add camera id system property to device tree build properties
persist.sys.vendor.camera_override_id=20 (desired camera id)

# Enabling MIUI camera mode support
# Add miui camera flag to device tree makefiles
TARGET_USES_MIUI_CAMERA := true

# Display 

# Increase/Reduce screen off blanking delay
persist.sys.screen.blank_delay=1000 (default)

# Increase/Reduce screen wake up delay
persist.sys.screen.wakeup_delay=1000 (default)

# Performance

# Increase/Reduce AOSP boostframework default boosting durations
persist.sys.powerhal.interaction.max=200 (default)

# Increase/Reduce Scarlet boostframework system boost boosting durations
persist.sys.powerhal.interaction.max_boost=2000 (default)

# Memory Management

# Max cached app processes in system, overrides "config_customizedMaxCachedProcesses"
persist.sys.fw.bg_apps_limit=96

# Code linaro LMKD properties and its AOSP counterparts - refer to perfconfigstore.xml (if available) for tuning purposes
# kill_heaviest_task_dup
ro.lmk.kill_heaviest_task=true
# kill_timeout_ms_dup
ro.lmk.kill_timeout_ms=100
# use_new_strategy_dup
ro.lmk.use_new_strategy=true
# thrashing_threshold
ro.lmk.thrashing_limit=30
# thrashing_decay
ro.lmk.thrashing_limit_decay=5
# nstrat_low_swap
ro.lmk.swap_free_low_percentage=10
# nstrat_psi_partial_ms
ro.lmk.psi_partial_stall_ms=70
# nstrat_psi_complete_ms
ro.lmk.psi_complete_stall_ms=70
# CLO lmkd [1] - others were not defined (will use default values from lmkd binary)
ro.lmk.psi_scrit_complete_stall_ms=75
ro.lmk.nstrat_wmark_boost_factor=4
ro.lmk.enable_watermark_check=true
ro.lmk.enable_userspace_lmk=true
ro.lmk.super_critical=701
ro.lmk.direct_reclaim_pressure=45
ro.lmk.reclaim_scan_threshold=0

# App compaction - refer to perfconfigstore.xml (if available) for tuning purposes
persist.sys.appcompact.enable_app_compact=false
persist.sys.appcompact.full_compact_type=2
persist.sys.appcompact.some_compact_type=4
persist.sys.appcompact.compact_throttle_somesome=5000
persist.sys.appcompact.compact_throttle_somefull=10000
persist.sys.appcompact.compact_throttle_fullsome=500
persist.sys.appcompact.compact_throttle_fullfull=10000
persist.sys.appcompact.compact_throttle_bfgs=600000
persist.sys.appcompact.compact_throttle_persistent=600000
persist.sys.appcompact.rss_throttle_kb=12000
persist.sys.appcompact.delta_rss_throttle_kb=8000
# Kernel-side fs-verity support was remove as per revision v8.6, 
# certain fs-verity related changes must be adapted to boot riceDroid on your Device

# Enable apk-fs-verity
ro.apk_verity.mode=2

# Required Apex Changes  - credits to eun0115
# Remove updatable apex make
# 1. remove this line if it exists on your device tree makefiles.
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# 2. Set ro.apex.updatable to false.
# Disable updatable apex
ro.apex.updatable=false

# 3. Enable flatten apex - add to your device tree makefiles.
OVERRIDE_TARGET_FLATTEN_APEX := true

# buildrom
. build/envsetup.sh
brunch "lancelot"

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
