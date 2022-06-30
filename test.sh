#!/bin/bash
set -e

echo "Checking clone-depth..."
if [[ -n $(grep "repo init" $CIRRUS_WORKING_DIR/build_rom.sh | grep "depth=1") ]]; then echo "Using clone depth as 1"; else echo "Please use '--depth=1' in the repo init line" && exit 1; fi

echo "Checking if 'default,-mips,-darwin,-notdefault' is present..."
if [[ -n $(grep "repo init" $CIRRUS_WORKING_DIR/build_rom.sh | grep "default,-mips,-darwin,-notdefault") ]]; then echo "'default,-mips,-darwin,-notdefault' are present in the repo init line"; else echo "Please use 'default,-mips,-darwin,-notdefault' in the repo init line" && exit 1; fi

echo "Checking if 'git clone' is used except for cloning local_manifest..."
if [[ -n $(grep "git clone" $CIRRUS_WORKING_DIR/build_rom.sh | grep ".repo/" $CIRRUS_WORKING_DIR/build_rom.sh) ]] && [[ $(grep "git clone" $CIRRUS_WORKING_DIR/build_rom.sh -wc) > 1 ]]; then echo "'git clone' is used for cloning other repos" && exit 1; else echo "'git clone' is used only for cloning local_manifest"; fi

echo "Checking if 'rm ' is used in build_rom.sh..."
if [[ -n $(grep "rm " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'rm' inside script, use local manifest for this purpose." && exit 1; else echo "'rm ' is not used in build_rom.sh"; fi

echo "Checking if 'sudo ' is used in build_rom.sh..."
if [[ -n $(grep "sudo " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'sudo' inside script." && exit 1; else echo "'sudo ' is not used in build_rom.sh"; fi

echo "Checking if 'repo forall ' is used in build_rom.sh..."
if [[ -n $(grep "repo forall " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'repo forall' inside script." && exit 1; else echo "'repo forall ' is not used in build_rom.sh"; fi

echo "Checking if 'curl ' is used in build_rom.sh..."
if [[ -n $(grep "curl " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'curl' inside script." && exit 1; else echo "'curl ' is not used in build_rom.sh"; fi

echo "Checking if 'mmma ' is used in build_rom.sh..."
if [[ -n $(grep "mmma " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'mmma' inside script." && exit 1; else echo "'mmma ' is not used in build_rom.sh"; fi

echo "Checking if 'mv ' is used in build_rom.sh..."
if [[ -n $(grep "mv " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'mv' inside script, use local manifest for this purpose." && exit 1; else echo "'mv ' is not used in build_rom.sh"; fi

echo "Checking if 'sed ' is used in build_rom.sh..."
if [[ -n $(grep "sed " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'sed' inside script, use local manifest for this purpose." && exit 1; else echo "'sed ' is not used in build_rom.sh"; fi

echo "Checking if 'tee ' is used in build_rom.sh..."
if [[ -n $(grep "tee " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'tee' inside script, its is not needed at all." && exit 1; else echo "'tee ' is not used in build_rom.sh"; fi

echo "Checking if ' clean' is used in build_rom.sh..."
if [[ -n $(grep " clean" $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use make clean. Server does make installclean by default, which is enough for most of the cases." && exit 1; else echo "'make clean' is not used in build_rom.sh"; fi

echo "Checking if ' clobber' is used in build_rom.sh..."
if [[ -n $(grep " clobber" $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use make clobber. Server does make installclean by default, which is enough for most of the cases." && exit 1; else echo "'make clobber' is not used in build_rom.sh"; fi

echo "Checking if ' installclean' is used in build_rom.sh..."
if [[ -n $(grep " installclean" $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use make installclean. Server does make installclean by default, which is enough for most of the cases." && exit 1; else echo "'make installclean' is not used in build_rom.sh"; fi

echo "Checking if 'blissify' is used in build_rom.sh..."
if [[ -n $(grep "blissify" $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use make clean / make installclean flag. Server does make installclean by default, which is enough for most of the cases." && exit 1; else echo "'blissify' is not used in build_rom.sh"; fi

echo "Checking if 'patch ' is used in build_rom.sh..."
if [[ -n $(grep "patch " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'patch ' inside script, use local manifest for this purpose." && exit 1; else echo "'patch ' is not used in build_rom.sh"; fi

echo "Checking if ' && ' is used in build_rom.sh..."
if [[ -n $(grep " && " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use ' && ' inside script, put that command in next line for this purpose." && exit 1; else echo "' && ' is not used in build_rom.sh"; fi

echo "Checking if ' & ' is used in build_rom.sh..."
if [[ -n $(grep " & " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use ' & ' inside script, put that command in next line for this purpose." && exit 1; else echo "' & ' is not used in build_rom.sh"; fi

echo "Checking if 'git fetch ' is used in build_rom.sh..."
if [[ -n $(grep "git fetch " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'git fetch ' inside script, use local manifest for this purpose." && exit 1; else echo "'git fetch ' is not used in build_rom.sh"; fi

echo "Checking if 'repopick ' is used in build_rom.sh..."
if [[ -n $(grep "repopick " $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'repopick ' inside script, use local manifest for this purpose." && exit 1; else echo "'repopick ' is not used in build_rom.sh"; fi

echo "Checking if 'cd *' is used in build_rom.sh..."
if [[ -n $(grep "cd *" $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'cd *' inside script, use local manifest for this purpose." && exit 1; else echo "'cd *' is not used in build_rom.sh"; fi

echo "Checking if '||' is used in build_rom.sh..."
if [[ -n $(grep "||" $CIRRUS_WORKING_DIR/build_rom.sh) ]]; then echo "Please dont use 'or' operator inside script." && exit 1; else echo "||*' is not used in build_rom.sh"; fi

sync_check=$(grep 'repo sync' $CIRRUS_WORKING_DIR/build_rom.sh)
sync_string="repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j"
if [[ $sync_check != *$sync_string* ]]; then echo Please follow repo sync line of main branch.; exit 1; fi

rclone_check=$(grep 'rclone copy' $CIRRUS_WORKING_DIR/build_rom.sh)
rclone_string="rclone copy out/target/product/\$(grep unch \$CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:\$(grep unch \$CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P"
if [[ $rclone_check != *$rclone_string* ]]; then echo Please follow rclone copy line of main branch.; exit 1; fi

url=https://$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 3-5 | cut -d ' ' -f 1)
r_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
name_check=$(curl -Ls $url 2>&1 | grep 'repo init' | grep $r_name | wc -l)
if [[ $r_name == "Havoc-OS" ]]; then name_check=1; fi
if [[ $name_check == 0 ]]; then echo Please use init line url from rom manifest, its case sensitive. Also follow the format of build_rom.sh file of temporary repo main branch.; exit 1; fi

command=$(tail $CIRRUS_WORKING_DIR/build_rom.sh -n +$(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1)| head -n -1 | grep -v 'rclone copy')
j_check=$(tail $CIRRUS_WORKING_DIR/build_rom.sh -n +$(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1)| head -n -1 | grep -v 'rclone copy' | grep '\-j' | wc -l)
if [[ $j_check -gt 0 ]]; then echo Please dont specify j value in make line.; exit 1; fi

rom_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
branch_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
rom_name=$rom_name-$branch_name
supported_roms=' AICP-s12.1 AOSPA-sapphire AospExtended-12.1.x AOSPK-twelve ArrowOS-arrow-12.1 BlissRoms-arcadia-next Bootleggers-BrokenLab-sambun CarbonROM-cr-9.0 CherishOS-twelve-one CipherOS-twelve-L ConquerOS-twelve Corvus-R-12-test crdroidandroid-11.0 crdroidandroid-12.1 DotOS-dot12.1 Evolution-X-elle Evolution-X-snow Fork-Krypton-A12 ForkLineageOS-lineage-19.1 Fusion-OS-twelve Havoc-OS-eleven Komodo-OS-12.1 lighthouse-os-sailboat_L1 LineageOS-lineage-17.1 LineageOS-lineage-18.1 LineageOS-lineage-19.1 P-404-shinka PixelExperience-twelve PixelExperience-twelve-plus PixelExtended-snow PixelOS-Pixelish-twelve PixysOS-twelve PotatoProject-frico_mr1-release projectarcana-aosp-12.x Project-Awaken-12.1 ProjectBlaze-12.1 Project-Fluid-fluid-12.1 ProjectRadiant-twelve ProjectStreak-twelve.one ResurrectionRemix-Q ShapeShiftOS-android_12 Spark-Rom-spark SuperiorOS-twelvedotone StagOS-s12.1 StyxProject-S syberia-project-12.1 The-RAVEN-OS-twelve VoltageOS-12l xdroid-oss-twelve yaap-twelve '
if [[ $supported_roms != *" $rom_name "* ]]; then echo Not supported rom or branch.; exit 1; fi

device=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
grep _jasmine_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=jasmine_sprout
grep _laurel_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=laurel_sprout
grep _GM8_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=GM8_sprout
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
for value in vicenteicc2008 random2907 RioChanY ajitlenka30 basic-general ZunayedDihan Badroel07 Ravithakral SumonSN SevralT yograjsingh-cmd nit-in Sanjeev stunner ini23 CyberTechWorld horoid ishakumari772 atharv2951 Lite120 anant-goel 01soni247 fakeriz Krtonia
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
