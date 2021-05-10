#!/bin/bash
# Script by FrosT2k5

init=$(sed -n '4p' < build_rom.sh)
check1=$(echo $init | grep -n \ -\-depth=1 | cut -d ":" -f 1)
check2=$(echo $init | grep -n \ -g\ default,\-device,\-mips,\-darwin,\-notdefault | cut -d ":" -f 1)

man=$(sed -n '5p' < build_rom.sh)
check3=$(echo $man | grep -n \ -\-depth\ 1  | cut -d ":" -f 1)

line4="repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j\$(nproc --all)"
check4=$(sed -n '6p' < build_rom.sh)

rm_check=$(cat build_rom.sh | grep -oi rm\ -rf build_rom.sh  | wc -l)
git_check=$(cat build_rom.sh | grep -oi git\ clone build_rom.sh  | wc -l)

line_check=$(wc -l build_rom.sh | cut -d " " -f 1)
if [ ${check1} == 1 ]
then
    echo -e "Check 1 Passed"
else
    echo -e "\n\nFailed"
    echo "Looks like your repo init doesnt have depth=1 or you aren't using the provided script for building"
    exit
fi

if [ ${check2} == 1 ]
then
    echo "Check 2 Passed"
else
    echo -e "\n\nFailed"
    echo "Looks like you arent doing repo init with groups (-g default,-device,-mips,-darwin,-notdefault), Please use the provided script with your rom changes"
    exit
fi

if [ ${check3} == 1 ]
then
    echo "Check 3 Passed"
else
    echo -e "\n\nFailed"
    echo "Looks like you arent cloning local manifest with --depth 1, please correct it"
    exit
fi

if [ "$check4" == "$line4" ]
then
    echo "Check 4 Passed"
else
    echo -e "\n\nFailed"
    echo "Looks like the repo sync command isn't similar to the one in the provided script... please correct this issue"
    exit
fi

if [ $rm_check == 0 ]
then
    echo "RM check Passed"
else
    echo -e "\n\nFailed"
    echo "rm -rf isn't allowed in the script. Please do those in your local manifest"
    exit
fi

if [ $git_check == 1 ]
then
    echo "Git check Passed"
else
    echo -e "\n\nFailed"
    echo "You probably are using more than one git clone statement in your script,or maybe you arent using any. Please fix this, there should be one and only one git clone statement"
    exit
fi

if [ $line_check == 14 ]
then
    echo "Line check Passed"
else
    echo -e "\n\nFailed"
    echo "Looks like you have more than 14 lines in your script, please use the provided script with your rom bringup and dont add extra lines"
    exit
fi


