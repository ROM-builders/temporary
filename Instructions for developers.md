This is a **reference** guide for newbies (by a newbie) but I expect you already know basics of Linux and Git. I will keep this guide easy to understand by using simple terms. So let us begin.

# Things you will need
- A good PC/server
- Build environment ready setup
- ROM sources
- Device Sources

## Required system/server
You would need a good Linux system with good internet speed. You can also build on other operating systems but Linux is the best choice, so I will go with Linux for this guide.

If you don't have a good PC, get a server, Google, Microsoft, Digital Ocean, etc. provide trials to test their services. Go get a trial on any of these, Google would be the best choice here.

Make a server with around 300 GB storage (at least 250 GB for one ROM + 50 ccache), 16 GB minimum RAM and 8 cores of vCPUs. You can create a more powerful server but Google offers up to 8 cores in the free trial. Choose Ubuntu 18.04 as OS or the latest one, at the time of writing this guide 18.04 is the latest LTS, sooooo.

## Getting ready build environment
After creating your server, it is time to set up the environment. Akhil Narang has made our life easy with his scripts, head over to [https://github.com/akhilnarang/scripts](https://github.com/akhilnarang/scripts "https://github.com/akhilnarang/scripts") and execute an appropriate script.

In our example I chose Ubuntu and here I have made a one-run script to get set up ready by using Akhilnarag's scripts :3
But before you proceed, I will recommend you to open a tmux session so if SSH connection is lost, we don't lose our progress and mess up things.

Opening a tmux session is easy, just run command "tmux", and if you lost your connect, connect to the server again and run "tmux attach". It will attach you to the session we created. You can create separate sessions but to keep this guide newbie-friendly, do as it is :D

Okay so now get your setup ready by executing the following:

`wget https://raw.githubusercontent.com/AliHasan7671/scripts/master/setup.sh && bash setup.sh`

It will install all required packages including Git, repo etc. It will also setup ccache with 50 GB limit. Now we have our setup ready.

## ROM sources
Now we need sources of the ROM which we want to compile. For this guide, I will go with AOSiP. AOSiP sources can be found here https://github.com/AOSiP.

Make a directory for the ROM and cd to it, for example:
`mkdir ~/aosip && cd ~/aosip`

Now it is time to sync ROM sources, you can find manifest of the ROM easily by looking over its GitHub. AOSiP has it here 
https://github.com/AOSiP/platform_manifest, we can also append .git to the URL, see below.

The common way to initialize and sync is:

`repo init -u URL-OF-MANIFEST -b BRANCH-NAME`

`repo sync -f --force-sync --no-tags --no-clone-bundle`

So for AOSiP we need to do:

`repo init -u git://github.com/AOSiP/platform_manifest.git -b pie`

and then start syncing with below command

`repo sync -f --force-sync --no-tags --no-clone-bundle`

Wait for sometime as it needs to download a huge amount of data. All depends on your internet speed, in our example server it would take around 30 minutes to sync.

## Device Sources
Once you are done syncing ROM sources, it is time to get device sources like Device tree, Kernel source, and vendor etc. Some devices also have common trees.

It is on you to find which stuff do you need, an easy way is to check lineage tree of your device, there you will get dependencies file containing all required things.

Clone everything in an appropriate directory, the common way to clone any repo is:

`git clone URL-OF-REPO -b BRANCH-NAME path/to/clone/at`

Device tree is cloned at "device/brand/device-code-name. Kernel, vendor and common tree(if any) paths can be found in BoardConfig.mk of your device tree. Here I will take mido as an example, let us clone required things for it.

`git clone https://github.com/AliHasan7671/android_device_xiaomi_mido -b pie device/xiaomi/mido`

Now in BoardConfig.mk I can see that my kernel should be at **kernel/xiaomi/msm853** and vendor should be at **vendor/xiaomi**

Cloning vendor

`git clone https://github.com/AliHasan7671/proprietary_vendor_xiaomi -b pie vendor/xiaomi`

Cloning kernel

`git clone https://github.com/AliHasan7671/android_kernel_xiaomi_msm8953 -b pie kernel/xiaomi/msm8953`

## Modifying tree for ROM
Now we are done cloning mido sources. We need to change our device tree for AOSiP. Let me show you how to do it, you can do the same for most of the ROMs.

Few ROMs need extra changing but this guide is for newbies soooo!

I will change directory to device i.e., cd device/xiaomi/mido. There I will find some device make file, if you are getting your tree from lineage, it would be lineage.mk. Few ROMs uses like conename_romname.mk

Here I need to rename lineage.mk to aosip.mk and then modify few lines inside it. See below

`mv lineage.mk mido.mk`

It will rename our file, now I will open it in nano for editing:

`nano aosip.mk`

Now here at this point, you will see a line which calling some common lineage stuff:

`$(call inherit-product, vendor/lineage/config/common_full_phone.mk)`

We need to change that this to call our target ROM common stuff, check ROMs vendor and you will find it. For AOSiP and most of the ROMs it is same, we just need to change that lineage to ROM name, see below:

`$(call inherit-product, vendor/aosip/config/common_full_phone.mk)`

As you can see I replaced lineage with aosip. Now we need to change product name. You will this line in the same file:

`PRODUCT_NAME := lineage_mido`

We need to replace lineage with our target ROM i.e., AOSiP, so:

`PRODUCT_NAME := aosip_mido`

Now save it and exit by executing CTRL+X

Now edit AndroidProducts.mk and replace makefile with our newly created one. So I will change lineage.mk to aosip_mido.mk
That is it, our basic things are done for the device, it is time to compile ROM. yayyyy

## Compiling ROM
Change directory to ROM sources i.e., cd ~/aosip and execute the following to source:

`source build/envsetup.sh`

Now lunch our device with preferred build variant, userdebug is good to go.

`lunch aosip_mido-userdebug`

Now we need to execute our final compiling command, it depends on the ROM which one it uses, most of the ROMs have brunch so doing brunch mido will start compiling the ROM, but AOSiP doesn't support, it supports mka so we will execute:

`time mka kronic`

Now our compilation will start, it will take around 150 minutes on our created instance :D If everything goes fine you will your ROM.zip at **out/target/product/mido**.

If you face any issue, contact your device maintainers for help :) Just spam them for help :3 Most of them are very **NOOB** and reply nicely.

So it was a **reference** guide for newbies by a newbie, take it as a reference only because things are different for every device and every ROM. I hope it helped you!
