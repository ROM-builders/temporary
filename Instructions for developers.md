## Steps:
##### 1. Find your device tree, kernel tree, and vendor tree. I made [here](https://github.com/nekoshirro/). You can find your device tree, common tree, and vendor tree.
##### 2. Make device tree of Redmi Note 9 Pro compatible with AOSP (for example, Evolution X) [bringup commit](https://github.com/nekoshirro/platform_device_xiaomi_joyeuse/commit/fa0098a8de27ac2381fc95875cde73e9cbe4328e)
##### 3. Initialize the Evolution X Source

`repo init --depth=1 -u https://github.com/Evolution-X/manifest -b snow`

##### 4. Change repository of Evolution X if needed by removing and reclonig them, or by using [local manifest](https://forum.xda-developers.com/t/learn-about-the-repo-tool-manifests-and-local-manifests-and-5-important-tips.2329228/)

You can also clone device tree, common device tree, kernel tree, vendor tree by local manifist too.

`git clone https://github.com/nekoshirro/local_manifests.git --depth 1 -b evox-12 .repo/local_manifests`

##### 5. Sync the source.

`repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8`

##### 6. Clone device tree, common device tree (if exists), kernel tree and vendor tree for Redmi Note 9 Pro to specific folder. Where to clone trees>

We need to clone device tree in device/xiaomi/joyeuse said in [here](https://github.com/nekoshirro/platform_device_xiaomi_joyeuse/blob/evox-12/BoardConfig.mk#L13)

We need to clone common tree in device/xiaomi/sm6250-common said in [here](https://github.com/nekoshirro/platform_device_xiaomi_sm6250-common/blob/evox-12/BoardConfigCommon.mk#L7)

We need to clone kernel tree in kernel/xiaomi/sm6250 said in [here](https://github.com/nekoshirro/platform_device_xiaomi_sm6250-common/blob/evox-12/BoardConfigCommon.mk#L90)

We need to clone spesific vendor tree in vendor/xiaomi/joyeuse said in [here](https://github.com/nekoshirro/platform_device_xiaomi_joyeuse/blob/evox-12/BoardConfig.mk#L11)

We need to clone common vendor tree in vendor/xiaomi/sm6250-common said in [here](https://github.com/nekoshirro/platform_device_xiaomi_sm6250-common/blob/evox-12/BoardConfigCommon.mk#L236)

```
git clone -b evox-12 https://github.com/nekoshirro/platform_device_xiaomi_joyeuse device/xiaomi/joyeuse --depth=1
git clone -b evox-12 https://github.com/nekoshirro/platform_device_xiaomi_sm6250-common device/xiaomi/sm6250-common --depth 1
git clone -b twelve https://github.com/nekoshirro/platform_kernel_xiaomi_sm6250 kernel/xiaomi/sm6250 --depth=1
git clone -b twelve https://github.com/nekoshirro/platform_vendor_xiaomi_sm6250-common vendor/xiaomi/sm6250-common --depth 1
git clone -b twelve https://github.com/nekoshirro/platform_vendor_xiaomi_joyeuse vendor/xiaomi/joyeuse --depth=1
```

If you used local manifest to clone these trees, you must skip cloning these trees in this step.

##### 7. Run the build commands for building Evolution X

```
source build/envsetup.sh
lunch evolution_joyeuse-userdebug
mka evolution -j$(nproc --all)
```

##### 8. Upload the output zip file (evolution_joyeuse*.zip) to a safe place
```
up(){
        curl --upload-file $1 https://transfer.sh/$(basename $1); echo
        # 14 days, 10 GB limit
}

up out/target/product/joyeuse/*.zip
```
##### 9. All these steps should be inside build_rom.sh script like [this](https://github.com/nekoshirro/ROM-Builders_CI/blob/main/build_rom.sh).
##### 10. If you want to update you device, kernel or vendor trees and learn more how to build ROMS and modify it according to your need, please check before build
https://github.com/AliHasan7671/guides/commit/33361bb2c78af01426350ef21167d742f44481fd
##### 11. You can use this repository as a standard reference and edit things according to your device, ROM, and needs
