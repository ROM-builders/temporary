<?xml version="1.0" encoding="UTF-8"?>  

<manifest>
        
        <!-- fetching sources -->      

        <remote name="Rinto02"
                fetch="https://github.com/rinto02" />

         <remote name="r450784d"
                fetch="https://gitlab.com/rintokhan" />

         <remote name="mountain47"
                fetch="https://github.com/mountain47" />
 
        <remote name="Realme-G70-Series"
                fetch="https://github.com/Realme-G70-Series" />



      <!-- device trees -->

     <project path="device/realme/RMX2193" name="android_device_realme_RMX2193" remote="mountain47" revision="11" />
     <project path="vendor/realme/RMX2193" name="vendor_realme_RMX2193" remote="mountain47" revision="11" />
      <project path="kernel/realme/RMX2193" name="kernel_realme_RMX2193" remote="mountain47" revision="Q" clone-depth="1" />
      <project path="packages/apps/RealmeDirac" name="android_packages_apps_RealmeDirac" remote="Realme-G70-Series" revision="master" clone-depth="1" />

        
      <!-- clang -->

        <project path="prebuilts/clang/host/linux-x86/clang-proton" name="proton-clang" remote="Rinto02" revision="main" clone-depth="1" />
        <project path="prebuilts/clang/host/linux-x86/clang-r450784d" name="clang-r450784d" remote="r450784d" revision="master" clone-depth="1" />
 
</manifest>
