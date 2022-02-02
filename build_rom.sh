#! /bin/bash
# shellcheck disable=SC2154

 # Script For Building Android Open Source Project
 #
 # Copyright (c) 2022 Hafidz Muzakky <nekoskuy.ubuntu@gmail.com>
 #
 # Licensed under the Apache License, Version 2.0 (the "License");
 # you may not use this file except in compliance with the License.
 # You may obtain a copy of the License at
 #
 #      http://www.apache.org/licenses/LICENSE-2.0
 #
 # Unless required by applicable law or agreed to in writing, software
 # distributed under the License is distributed on an "AS IS" BASIS,
 # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 # See the License for the specific language governing permissions and
 # limitations under the License.
 #

# Bail out if script fails
set -e

# Function to show an informational message
msg() {
	echo
	echo -e "\e[1;32m$*\e[0m"
	echo
}

err() {
	echo -e "\e[1;41m$*\e[0m"
	exit 1
}

cdir() {
	cd "$1" 2>/dev/null || \
		err "The directory $1 doesn't exists !"
}

##------------------------------------------------------##
##----------Basic Informations, COMPULSORY--------------##

# Build Author
# Take care, it should be a universal and most probably, case-sensitive
AUTHOR="Tumbal-prjkt"

# Branding
CUSTOM_BUILD_TYPE="Kazuha"

# PixelPlusUI Props
PPUI_BASE_VERSION="4.1"

CUSTOM_DATE_YEAR="$(date -u +%Y)"
CUSTOM_DATE_MONTH="$(date -u +%m)"
CUSTOM_DATE_DAY="$(date -u +%d)"
CUSTOM_DATE_HOUR="$(date -u +%H)"
CUSTOM_DATE_MINUTE="$(date -u +%M)"
# CUSTOM_BUILD_DATE_UTC="$(date -d '$(CUSTOM_DATE_YEAR)-$(CUSTOM_DATE_MONTH)-$(CUSTOM_DATE_DAY) $(CUSTOM_DATE_HOUR):$(CUSTOM_DATE_MINUTE) UTC' +%s)"
CUSTOM_BUILD_DATE="${CUSTOM_DATE_YEAR}${CUSTOM_DATE_MONTH}${CUSTOM_DATE_DAY}-${CUSTOM_DATE_HOUR}${CUSTOM_DATE_MINUTE}"

CUSTOM_PLATFORM_VERSION="12.0"

ZIPNAME="PixelPlusUI_${PPUI_BASE_VERSION}_${CUSTOM_BUILD}-${CUSTOM_PLATFORM_VERSION}-${CUSTOM_BUILD_DATE}-${CUSTOM_BUILD_TYPE}"
CUSTOM_VERSION_PROP="twelve"

# Shellcheck source=/etc/os-release
DISTRO=$(source /etc/os-release && echo "$(NAME)")

# Basic Information
MODEL="Google Pixel 6 Pro"
DEVICE="raven"
ROM="PixelPlusUI"
BRANCH="SnowCone (Android 12 release 27)"
SECPATCH="January 5, 2022"
DATE=$(TZ=Asia/Jakarta date +"%Y%m%d-%T")
HOST="Hafidz's Laboratory"

# Push ZIP to Telegram. 1 is YES | 0 is NO(default)
PTTG=1
	if [ $PTTG = 1 ]
	then
		# Set Telegram Chat ID
		CHATID="-1001580662294"
		TG_TOKEN="5171513339:AAFMofFtLRVxsPlGhqjAFA-gjMyQLMfK2ns"
	fi

# Check Kernel Version
KERVER=$(cd kernel/xiaomi/sm6250 && make kernelversion)

exports() {

         KBUILD_BUILD_USER=$AUTHOR
		 BOT_MSG_URL="https://api.telegram.org/bot${TG_TOKEN}/sendMessage"
		 BOT_BUILD_URL="https://api.telegram.org/bot${TG_TOKEN}endDocument"
		 PROCS=$(nproc --all)
		 
		 export BOT_BUILD_URL BOT_MSG_URL PROCS

}

##----------------------------------------------------------------##

tg_post_msg() {
	curl -s -X POST "$BOT_MSG_URL" -d chat_id="$CHATID" \
	-d "disable_web_page_preview=true" \
	-d "parse_mode=html" \
	-d text="$1"

}

##----------------------------------------------------------------##

tg_post_build() {
	# Post MD5Checksum alongwith for easeness
	MD5CHECK=$(md5sum "$1" | cut -d' ' -f1)

	#Show the Checksum alongwith caption
	curl --progress-bar -F document=@"$1" "$BOT_BUILD_URL" \
	-F chat_id="$CHATID"  \
	-F "disable_web_page_preview=true" \
	-F "parse_mode=Markdown" \
	-F caption="$2 | *MD5 Checksum : *\`$MD5CHECK\`"
}

# Sync ROM
repo init --depth=1 --no-repo-verify -u https://github.com/PixelPlusUI-SnowCone/manifest -b snowcone -g default,-mips,-darwin,-notdefault
git clone https://github.com/tumbal-prjkt/manifest.git --depth 1 -b ppui .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Build The ROM
build_rom() {
		if [ "$PTTG" = 1 ]
		then
				tg_post_msg "<b>🔨 ROM Build Started</b>%0A<b>Linux Version: </b><code>$DISTRO</code>%0A<b>ROM : </b><code>$ROM</code>%0A<b>Kernel Version : </b><code>$KERVER</code>%0A<b>Security Patch : </b><code>$SECPATCH</code>%0A<b>Date : </b><code>$(TZ=Asia/Jakarta date)</code>%0A<b>Device : </b><code>$MODEL [$DEVICE]</code>%0A<b>Build Environment : </b><code>$HOST</code>%0A<b>CPU Core : </b><code>$PROCS</code>%0A<b>Branch : </b><code>$BRANCH</code>"
		fi
	
		BUILD_START=$(date +"%s")

		msg "|| ROM Build Started ||"
		
		source build/envsetup.sh
		lunch aosp_joyeuse-userdebug
		export TZ=Asia/Jakarta # Put before last build command
		mka bacon
		
		BUILD_END=$(date +"%s")
		DIFF=$((BUILD_END - BUILD_START))
		
		if [ -f "$(PWD)"/out/target/product/joyeuse/$ZIPNAME ]
		then
			msg "|| Build Completed Successfully ||"
			else
			if [ "$PTTG" = 1 ]
 			then
				tg_post_msg "*❌ Build failed to compile after $((DIFF / 60)) minute(s) and $((DIFF % 60)) seconds*"
			fi
		fi 
}

# Push ROM to Telegram
push_telegram() {
		cd out/target/product/joyeuse
		
		if [ "$PTTG" = 1 ]
		then
				tg_post_build "$ZIPNAME.zip" "✅ Build took : $((DIFF / 60)) minute(s) and $((DIFF % 60)) second(s)"
		fi

}

# Upload ROM (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

