<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  
<remote name="ahmedhridoy371" fetch="https://github.com/ahmedhridoy371" />
<remote name="kdrag0n" fetch="https://github.com/kdrag0n" />
<remote name="nexus" fetch="https://github.com/projects-nexus" /> 
<remote name="Arrow-Devices" fetch="https://github.com/ArrowOS-Devices" />
<remote name="PE" fetch="https://github.com/PixelExperience-Devices" />

     <!--Trees-->

  <project path="device/xiaomi/lavender" name="device_xiaomi_lavender" remote="ahmedhridoy371" revision="13-4.4" />
           
  <project path="vendor/xiaomi/lavender" name="vendor_xiaomi_lavender" remote="ahmedhridoy371" revision="13-4.4" />

  <!--project path="kernel/xiaomi/lavender" name="kernel_xiaomi_lavender" remote="ahmedhridoy371" revision="thirteen" /-->

  <!--project path="kernel/xiaomi/lavender" name="nexus_kernel_xiaomi_lavender" remote="nexus" revision="qti" /-->

  <project path="kernel/xiaomi/lavender" name="kernel_xiaomi_lavender" remote="PE" revision="thirteen" />
  
    <!-- Toolchain -->

  <!--project path="prebuilts/clang/host/linux-x86/clang-proton" name="proton-clang" remote="kdrag0n" revision="master" clone-depth="1" /-->

</manifest>
