#!/usr/bin/env bash

set -e
rom_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
branch_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
rom_name=$rom_name-$branch_name
ax613_roms=" crdroidandroid-13.0 Octavi-Staging-thirteen "
if [[ $ax613_roms != *" $rom_name "* ]]; then exit 0; fi
mkdir -p ~/roms/$rom_name
cd ~/roms/$rom_name
set -exv
curl -sO https://api.cirrus-ci.com/v1/task/$CIRRUS_TASK_ID/logs/sync.log
a=$(grep 'Cannot remove project' sync.log -m1|| true)
b=$(grep "^fatal: remove-project element specifies non-existent project" sync.log -m1 || true)
c=$(grep 'repo sync has finished' sync.log -m1 || true)
d=$(grep 'Failing repos:' sync.log -n -m1 || true)
e=$(grep 'fatal: Unable' sync.log || true)
f=$(grep 'error.GitError' sync.log || true)
g=$(grep 'error: Cannot checkout' sync.log || true)
if [[ $a == *'Cannot remove project'* ]]
then
a=$(echo $a | cut -d ':' -f2 | tr -d ' ')
rm -rf $a
fi
if [[ $b == *'remove-project element specifies non-existent'* ]]
then exit 1
fi
if [[ $d == *'Failing repos:'* ]]
then
d=$(expr $(grep 'Failing repos:' sync.log -n -m 1| cut -d ':' -f1) + 1)
d2=$(expr $(grep 'Try re-running' sync.log -n -m1 | cut -d ':' -f1) - 1 )
fail_paths=$(head -n $d2 sync.log | tail -n +$d)
for path in $fail_paths
do
rm -rf $path
aa=$(echo $path|awk -F '/' '{print $NF}')
rm -rf .repo/project-objects/*$aa.git .repo/projects/$path.git
done
fi
if [[ $e == *'fatal: Unable'* ]]
then
fail_paths=$(grep 'fatal: Unable' sync.log | cut -d ':' -f2 | cut -d "'" -f2)
for path in $fail_paths
do
rm -rf $path
aa=$(echo $path|awk -F '/' '{print $NF}')
rm -rf .repo/project-objects/*$aa.git .repo/project-objects/$path.git .repo/projects/$path.git
done
fi
if [[ $f == *'error.GitError'* ]]
then
