#!/bin/bash

#######################
romname=rr
user=Headache01
email=ismailduyan80@gmail.com
repo=https://github.com/ResurrectionRemix/platform_manifest.git
repobranch=Q
manifest=https://github.com/Headache01/local_manifest.git
manifestbranch=main
job=18
ccache=50G
device=rr_GM8_sprout
variant=userdebug
codename=GM8_sprout
########################

apt update
apt install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python python3 jq
cd
mkdir $romname
cd $romname
mkdir -p ~/.bin
PATH="${HOME}/.bin:${PATH}"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo
git config --global user.email $email
git config --global user.name $user
repo init -u $repo -b $repobranch
git clone $manifest --depth 1 -b $manifestbranch .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$job


export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M $ccache

export LC_ALL=C
. build/envsetup.sh
lunch $device-$variant
mka bacon -j$job
cd $romname/out/target/product/$codename
wget https://raw.githubusercontent.com/Sushrut1101/GoFile-Upload/master/upload.sh
