#!/usr/bin/env bash

set -e

ccheck(){
	check=$(grep "$1" $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
	if [[ $check -gt 0 ]]; then echo "$2"; exit 1; fi
}

ccheck 'rm ' 'Please dont use rm inside script, use local manifest for this purpose.'
ccheck 'find ' 'Please dont use find inside script, use local manifest for this purpose.'
ccheck 'unlink ' 'Please dont use unlink inside script, use local manifest for this purpose.'
ccheck 'shred ' 'Please dont use shred inside script, use local manifest for this purpose.'
ccheck 'sudo ' 'Please dont use sudo inside script.'
ccheck 'repo forall ' 'Please dont use repo forall inside script.'
ccheck 'curl ' 'Please dont use curl inside script.'
ccheck 'mmma ' 'Please dont use mmma inside script.'
ccheck 'mv ' 'Please dont use mv inside script, use local manifest for this purpose.'
ccheck 'sed ' 'Please dont use sed inside script, use local manifest for this purpose.'
ccheck 'tee ' 'Please dont use tee inside script, its not needed at all..'
ccheck ' clean' 'Please dont use make clean. Server does make installclean by default, which is enough for most of the cases.'
ccheck ' clobber' 'Please dont use make clobber. Server does make installclean by default, which is enough for most of the cases.'
ccheck ' installclean' 'Please dont use make installclean. Server does make installclean by default, which is enough for most of the cases.'
ccheck 'cmka ' 'Please dont use cmka. Server does make installclean by default, which is enough for most of the cases.'
ccheck 'patch ' 'Please dont use patch inside script, use local manifest for this purpose.'
ccheck ' && ' 'Please dont use && inside script, put that command in next line for this purpose.'
ccheck ' & ' 'Please dont use & inside script.'
ccheck "||" 'Please dont use or operator inside script'
ccheck 'git fetch ' 'Please dont use fetch inside script, use local manifest for this purpose.'
ccheck 'repopick ' 'Please dont use repopick inside script, use local manifest for this purpose.'
ccheck "cd *" 'Please dont use cd inside script, use local manifest for this purpose.'

init_check=$(grep 'repo init' $CIRRUS_WORKING_DIR/build_rom.sh | grep 'depth=1')
if [[ $init_check != *default,-mips,-darwin,-notdefault* ]]; then echo Please use --depth=1 and -g default,-mips,-darwin,-notdefault tags in repo init line.; exit 1; fi

clone_check=$(grep 'git clone' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $clone_check -gt 1 ]]; then echo Please use local manifest to clone trees and other repositories, we dont allow git clone to clone trees.; exit 1; fi

manifests_check=$(grep 'git clone' $CIRRUS_WORKING_DIR/build_rom.sh)
if [[ $manifests_check != *.repo/local_manifests* ]]; then echo Please follow git clone line from main branch.; exit 1; fi

url=https://$(grep 'repo init' $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 3-5 | cut -d ' ' -f 1)
r_name=$(grep 'repo init' $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
name_check=$(curl -Ls $url 2>&1 | grep 'repo init' | grep $r_name | wc -l)
if [[ $r_name == "Havoc-OS" ]]; then name_check=1; fi
if [[ $name_check == 0 ]]; then echo Please use init line url from rom manifest, its case sensitive. Also follow the format of build_rom.sh file of temporary repo main branch.; exit 1; fi

j_check=$(tail $CIRRUS_WORKING_DIR/build_rom.sh -n +$(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1)| head -n -1 | grep -v 'rclone copy' | grep '\-j' | wc -l)
if [[ $j_check -gt 0 ]]; then echo Please dont specify j value in make line.; exit 1; fi

bliss_check=$(grep blissify $CIRRUS_WORKING_DIR/build_rom.sh | grep '\-c' | wc -l)
if [[ $bliss_check -gt 0 ]]; then echo Please dont use make clean flag. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

bliss_check=$(grep blissify $CIRRUS_WORKING_DIR/build_rom.sh | grep '\--clean' | wc -l)
if [[ $bliss_check -gt 0 ]]; then echo Please dont use make clean flag. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

bliss_check=$(grep blissify $CIRRUS_WORKING_DIR/build_rom.sh | grep '\-d' | wc -l)
if [[ $bliss_check -gt 0 ]]; then echo Please dont use make installclean flag. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

bliss_check=$(grep blissify $CIRRUS_WORKING_DIR/build_rom.sh | grep '\--devclean' | wc -l)
if [[ $bliss_check -gt 0 ]]; then echo Please dont use make installclean flag. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

aospa_check=$(grep "rom-build.sh" $CIRRUS_WORKING_DIR/build_rom.sh | grep '\-c' | wc -l)
if [[ $aospa_check -gt 0 ]]; then echo Please dont use make clean flag. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

aospa_check=$(grep "rom-build.sh" $CIRRUS_WORKING_DIR/build_rom.sh | grep '\--clean' | wc -l)
if [[ $aospa_check -gt 0 ]]; then echo Please dont use make clean flag. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

aospa_check=$(grep "rom-build.sh" $CIRRUS_WORKING_DIR/build_rom.sh | grep '\-i' | wc -l)
if [[ $aospa_check -gt 0 ]]; then echo Please dont use make installclean flag. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

aospa_check=$(grep "rom-build.sh" $CIRRUS_WORKING_DIR/build_rom.sh | grep '\--installclean' | wc -l)
if [[ $aospa_check -gt 0 ]]; then echo Please dont use make installclean flag. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

rclone_check=$(grep 'rclone copy' $CIRRUS_WORKING_DIR/build_rom.sh)
rclone_string="rclone copy out/target/product/\$(grep unch \$CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:\$(grep unch \$CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P"
if [[ $rclone_check != *$rclone_string* ]]; then echo Please follow rclone copy line of main branch.; exit 1; fi

sync_check=$(grep 'repo sync' $CIRRUS_WORKING_DIR/build_rom.sh)
sync_string="repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8"
if [[ $sync_check != *$sync_string* ]]; then echo Please follow repo sync line of main branch.; exit 1; fi

rom_name=$(grep 'repo init' $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
branch_name=$(grep 'repo init' $CIRRUS_WORKING_DIR/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
rom_name=$rom_name-$branch_name
supported_roms=' AICP-t13.0 AICP-s12.1 alphadroid-project-alpha-13 AOSPA-topaz ArrowOS-arrow-13.1 bananadroid-13 BlissRoms-arcadia-next BlissRoms-typhoon BootleggersROM-tirimbino CarbonROM-cr-9.0 CherishOS-tiramisu CipherOS-thirteen crdroidandroid-11.0 crdroidandroid-12.1 crdroidandroid-13.0 DerpFest-12-12.1 DerpFest-AOSP-13 Evolution-X-tiramisu Fusion-OS-twelve Havoc-OS-twelve LineageOS-cm-14.1 LineageOS-lineage-15.1 LineageOS-lineage-16.0 LineageOS-lineage-17.1 LineageOS-lineage-18.1 LineageOS-lineage-19.1 LineageOS-lineage-20.0 Octavi-Staging-thirteen P-404-tokui PixelExperience-twelve PixelExperience-twelve-plus PixelExperience-thirteen PixelExperience-thirteen-plus PixelExtended-thunder PixelOS-AOSP-thirteen PixysOS-twelve PixysOS-thirteen Project-Awaken-triton ProjectBlaze-13 Project-Xtended-xt RisingTechOSS-thirteen ResurrectionRemix-Q ShapeShiftOS-android_13 Spark-Rom-pyro SuperiorOS-twelvedotone SuperiorOS-thirteen StagOS-t13 syberia-project-13.0 VoltageOS-13 xdroid-oss-thirteen yaap-thirteen '

if [[ $supported_roms != *" $rom_name "* ]]; then echo Not supported rom or branch.; exit 1; fi

device=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
grep _jasmine_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=jasmine_sprout
grep _laurel_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=laurel_sprout
grep _GM8_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=GM8_sprout
grep _SCW_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=SCW_sprout
grep _maple_dsds $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=maple_dsds

if [[ $BRANCH != *pull/* ]]; then 
	if [[ $BRANCH != $device-$rom_name-* ]]; then echo Please use proper branch naming described in push group.; exit 1; fi; 
	if [[ $CIRRUS_COMMIT_MESSAGE == "Update build_rom.sh" ]]; then echo Please use proper commit message.; exit 1; fi; 
fi

if [[ $device == 'copy' ]]; then echo "Please use lunch or brunch command with device codename after . build/envsetup.sh" ; exit 1; fi
if [[ $device == 'mi439' ]]; then echo "Please use device codename Mi439 also create your dt with this device code name." ; exit 1; fi

if [[ $BRANCH == *pull/* ]]; then
	if [[ $CIRRUS_COMMIT_MESSAGE != $device-$rom_name-* ]]; then echo Please use proper PR label described in telegram group.; exit 1; fi
	lunch_check=$(grep "unch" $CIRRUS_WORKING_DIR/build_rom.sh | grep -v 'rclone' | wc -l)
	if [[ $rom_name != 'Corvus-R-12-test' ]]; then
		if [[ $lunch_check -gt 1 ]]; then echo Please build for one device at a time.; exit 1; fi
	fi
	cd /tmp/cirrus-ci-build
	PR_NUM=$(echo $BRANCH|awk -F '/' '{print $2}')
	AUTHOR=$(gh pr view $PR_NUM|grep author| awk '{print $2}')

	for id in 66806243 25178653 100027207 77049889 37245252 87101173 91236805 56505303 77262770 60956846 1133897 92011891 80823029 58514579 102499518 73420351 69832543
	do
		logins+=" $(gh api -H "Accept: application/vnd.github+json" /user/$id -q '.login')"
	done

	for value in $logins
	do
		if [[ $AUTHOR == $value ]]; then echo Please check \#bad_people instruction in telegram group.; exit 1; fi
	done

	joindate=$(date -d $(curl -s https://api.github.com/users/$AUTHOR | grep created_at | cut -d '"' -f4) +%s)
	nowdate=$(date +%s)
	datediff=$(expr $nowdate - $joindate)
	if [[ $datediff -lt 2592000 ]]; then echo Please don\'t try to run build with your new account. Use your original account for doing PR.; exit 1; fi
fi

if [[ $CIRRUS_USER_PERMISSION == write ]]; then
	if [ -z "$CIRRUS_PR" ]; then true; else
		echo You are push user. Don\'t do pr and please follow pinned message in push group.; exit 1
	fi
fi

echo Test passed
echo "rom_name=$rom_name" >> $CIRRUS_ENV
echo "device=$device" >> $CIRRUS_ENV
