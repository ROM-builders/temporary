#!/bin/bash
set -e

init_check=$(grep 'repo init' $CIRRUS_WORKING_DIR/build_rom.sh | grep 'depth=1')
if [[ $init_check != *default,-mips,-darwin,-notdefault* ]]; then echo Please use --depth=1 and -g default,-mips,-darwin,-notdefault tags in repo init line.; exit 1; fi


clone_check=$(grep 'git clone' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $clone_check -gt 1 ]]; then echo Please use local manifest to clone trees and other repositories, we dont allow git clone to clone trees.; exit 1; fi

rm_check=$(grep 'rm ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $rm_check -gt 0 ]]; then echo Please dont use rm inside script, use local manifest for this purpose.; exit 1; fi

url=https://$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 3-5 | cut -d ' ' -f 1)
r_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
name_check=$(curl -Ls $url 2>&1 | grep 'repo init' | grep $r_name | wc -l)
if [[ $name_check == 0 ]]; then echo Please use init line url from rom manifest, its case sensitive. Also follow the format of build_rom.sh file of temporary repo main branch.; exit 1; fi

command=$(tail $CIRRUS_WORKING_DIR/build_rom.sh -n +$(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1)| head -n -1 | grep -v 'rclone copy')
j_check=$(tail $CIRRUS_WORKING_DIR/build_rom.sh -n +$(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1)| head -n -1 | grep -v 'rclone copy' | grep '\-j' | wc -l)
if [[ $j_check -gt 0 ]]; then echo Please dont specify j value in make line.; exit 1; fi

sudo_check=$(grep 'sudo ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $sudo_check -gt 0 ]]; then echo Please dont use sudo inside script.; exit 1; fi

forall_check=$(grep 'repo forall ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $forall_check -gt 0 ]]; then echo Please dont use repo forall inside script.; exit 1; fi

mmma_check=$(grep 'mmma ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $mmma_check -gt 0 ]]; then echo Please dont use mmma inside script.; exit 1; fi

mv_check=$(grep 'mv ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $mv_check -gt 0 ]]; then echo Please dont use mv inside script, use local manifest for this purpose.; exit 1; fi

sed_check=$(grep 'sed ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $sed_check -gt 0 ]]; then echo Please dont use sed inside script, use local manifest for this purpose.; exit 1; fi

tee_check=$(grep 'tee ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $tee_check -gt 0 ]]; then echo Please dont use tee inside script, its not needed at all..; exit 1; fi

clean_check=$(grep ' clean' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $clean_check -gt 0 ]]; then echo Please dont use make clean. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

bliss_check=$(grep blissify $CIRRUS_WORKING_DIR/build_rom.sh | grep '\-c' | wc -l)
if [[ $bliss_check -gt 0 ]]; then echo Please dont use make clean flag. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

bliss_check=$(grep blissify $CIRRUS_WORKING_DIR/build_rom.sh | grep '\-d' | wc -l)
if [[ $bliss_check -gt 0 ]]; then echo Please dont use make installclean flag. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

clobber_check=$(grep ' clobber' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $clobber_check -gt 0 ]]; then echo Please dont use make clobber. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

installclean_check=$(grep ' installclean' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $installclean_check -gt 0 ]]; then echo Please dont use make installclean. Server does make installclean by default, which is enough for most of the cases.; exit 1; fi

patch_check=$(grep 'patch ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $patch_check -gt 0 ]]; then echo Please dont use patch inside script, use local manifest for this purpose.; exit 1; fi

and_check=$(grep ' && ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $and_check -gt 0 ]]; then echo 'Please dont use && inside script, put that command in next line for this purpose.'; exit 1; fi

and_check2=$(grep ' & ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $and_check2 -gt 0 ]]; then echo 'Please dont use & inside script.'; exit 1; fi

rclone_check=$(grep 'rclone copy' $CIRRUS_WORKING_DIR/build_rom.sh)
rclone_string="rclone copy out/target/product/\$(grep unch \$CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:\$(grep unch \$CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P"
if [[ $rclone_check != *$rclone_string* ]]; then echo Please follow rclone copy line of main branch.; exit 1; fi

sync_check=$(grep 'repo sync' $CIRRUS_WORKING_DIR/build_rom.sh)
sync_string="repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j"
if [[ $sync_check != *$sync_string* ]]; then echo Please follow repo sync line of main branch.; exit 1; fi

fetch_check=$(grep 'git fetch ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $fetch_check -gt 0 ]]; then echo Please dont use fetch inside script, use local manifest for this purpose.; exit 1; fi

pick_check=$(grep 'repopick ' $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $pick_check -gt 0 ]]; then echo Please dont use repopick inside script, use local manifest for this purpose.; exit 1; fi

cd_check=$(grep "cd *" $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $cd_check -gt 0 ]]; then echo Please dont use cd inside script, use local manifest for this purpose.; exit 1; fi

or_check=$(grep "||" $CIRRUS_WORKING_DIR/build_rom.sh | wc -l)
if [[ $or_check -gt 0 ]]; then echo Please dont use or operator inside script; exit 1; fi

rom_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
branch_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')

#need to change total 8 times
for item in "LineageOS lineage-17.1" "LineageOS lineage-15.1" "LineageOS lineage-19.0" "ArrowOS arrow-12.0" "Project-Fluid fluid-12" "CipherOS twelve" "ProjectRadiant twelve" "Project-Awaken 12" "Octavi-OS 12" "Project-LegionOS 12" "ShapeShiftOS android_12" "lighthouse-os sailboat" "Evolution-X snow" "PotatoProject frico-release" "StyxProject S" "PixelExperience twelve" "CherishOS twelve" "Spark-Rom spark" "PixelExtended snow" "Corvus-R 12" "crdroidandroid 12.0" "AospExtended 12.x" "NusantaraProject-ROM 12"
do
item1=$(echo $item | awk -F ' ' '{print $1}')
item2=$(echo $item | awk -F ' ' '{print $2}')
if [[ $rom_name == $item1 ]]; then if [[ $branch_name == $item2 ]]; then rom_name=$rom_name-$branch_name; fi ;fi
done

if [[ $rom_name == LineageOS ]]; then if [[ $branch_name == lineage-16.1 ]]; then echo Only lineage-18.1, 17.1 and 15.1 is supported.; exit 1; fi ;fi
if [[ $rom_name == LineageOS ]]; then if [[ $branch_name == lineage-16.0 ]]; then echo Only lineage-18.1, 17.1 and 15.1 is supported.; exit 1; fi ;fi
if [[ $rom_name == LineageOS ]]; then if [[ $branch_name == lineage-15.0 ]]; then echo Only lineage-18.1, 17.1 and 15.1 is supported.; exit 1; fi ;fi
if [[ $rom_name == LineageOS ]]; then if [[ $branch_name == cm-14.1 ]]; then echo Only lineage-18.1, 17.1 and 15.1 is supported.; exit 1; fi ;fi
if [[ $rom_name == ArrowOS ]]; then if [[ $branch_name == 'arrow-10.0' ]]; then echo Only ArrowOS a11 and a12 is supported.; exit 1; fi ;fi
device=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
grep _jasmine_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=jasmine_sprout
grep _laurel_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=laurel_sprout

if [[ $BRANCH != *pull/* ]]; then if [[ $BRANCH != $device-$rom_name-* ]]; then echo Please use proper branch naming described in push group.; exit 1; fi; fi

if [[ $BRANCH == *pull/* ]]; then
cd /tmp/cirrus-ci-build
PR_NUM=$(echo $BRANCH|awk -F '/' '{print $2}')
AUTHOR=$(gh pr view $PR_NUM|grep author| awk '{print $2}')
for value in ajitlenka30 basic-general ZunayedDihan Badroel07 Ravithakral SumonSN SevralT yograjsingh-cmd nit-in Sanjeev stunner ini23 CyberTechWorld horoid ishakumari772 atharv2951 Lite120 anant-goel 01soni247
do
    if [[ $AUTHOR == $value ]]; then
    echo Please check \#pr instruction in telegram group.; exit 1; fi
done
fi

if [[ $CIRRUS_USER_PERMISSION == write ]]; then
if [ -z "$CIRRUS_PR" ]; then echo fine; else
echo You are push user. Don\'t do pr and please follow pinned message in push group.; exit 1
fi
fi

echo Test passed
