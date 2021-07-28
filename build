#!/bin/bash
cd /tmp/rom # Depends on where source got synced

# Patches
cd device/intex/Cloud_Q11/patches
bash apply-patches.sh
cd ../../../..

# Normal build steps
. build/envsetup.sh
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -s
ccache -M 20G # It took only 6.4GB for mido
ccache -o compression=true # Will save times and data to download and upload ccache, also negligible performance issue
ccache -z # Clear old stats, so monitor script will provide real ccache statistics

export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4096m"

./prebuilts/sdk/tools/jack-admin kill-server

./prebuilts/sdk/tools/jack-admin start-server

export LC_ALL=C

brunch Cloud_Q11

# Next 8 lines should be run first to collect ccache and then upload, after doning it 1 or 2 times, our ccache will help to build without these 8 lines
#make api-stubs-docs || echo no problem, we need ccache
#make hiddenapi-lists-docs || echo no problem, we need ccache
#make system-api-stubs-docs || echo no problem we need ccache
#make test-api-stubs-docs || echo no problem, we need ccache
#make aex -j10 & # dont remove that '&'
#sleep 85m
#kill %1
#ccache -s
#and dont use below codes for first 1 or 2 times, to get ccache uploaded,


# upload function for uploading rom zip file! I don't want unwanted builds in my google drive haha!
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

tg(){
	bot_api=1692865707:AAHvKZogI5sUGtqjd2sZvNl8tib0Q_xcYkY # Your tg bot api, dont use my one haha
	your_telegram_id=$1 # No need to touch 
	msg=$2 # No need to touch
	curl -s "https://api.telegram.org/bot${bot_api}/sendmessage" --data "text=$msg&chat_id=${your_telegram_id}"
}

#id=571213272 # Your telegram id

# Build command! j10 for 10 cpu, j8 for 8 cpu, otherwise memeroy will end up even its 24G
# Upload rom zip file if succeed to build! Send notification to tg! And send shell to tg if build fails!

# Let's compile by parts! Coz of ram issue!
# make api-stubs-docs || echo no problem
# make hiddenapi-lists-docs || echo no problem
# make system-api-stubs-docs || echo no problem
# make test-api-stubs-docs || echo no problem

# make aex -j10 \
#	&& send_zip=$(up out/target/product/mido/*zip) && tg $id "Build Succeed!
# $send_zip" \
#	|| tmate -S /tmp/tmate.sock new-session -d && tmate -S /tmp/tmate.sock wait tmate-ready && send_shell=$(tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}') && tg $id "Build Failed" && tg $id "$send_shell" && ccache -s && sleep 2h
ccache -s # Let's print ccache statistics finally
