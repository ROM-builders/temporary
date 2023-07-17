#!/usr/bin/env bash
mkdir -p ~/roms/$rom_name
cd ~/roms/$rom_name
find .repo -name '*.lock' -delete
curl -sO https://api.cirrus-ci.com/v1/task/$CIRRUS_TASK_ID/logs/sync.log

a=$(grep 'Cannot remove project' sync.log -m1|| true)
b=$(grep "^fatal: remove-project element specifies non-existent project" sync.log -m1 || true)
c=$(grep 'repo sync has finished' sync.log -m1 || true)
d=$(grep 'Failing repos:' sync.log -n -m1 || true)
e=$(grep 'fatal: Unable' sync.log || true)
f=$(grep 'error.GitError' sync.log || true)
g=$(grep 'error: Cannot checkout' sync.log || true)
echo -e "a=$a \nb=$b \nc=$c \nd=$d \ne=$e \nf=$f \ng=$g \n"

if [[ $a == *'Cannot remove project'* ]]; then
	a=$(echo $a | cut -d ':' -f2 | tr -d ' ')
	rm -rf $a
	echo removed $a
fi

if [[ $b == *'remove-project element specifies non-existent'* ]]; then exit 1; fi

if [[ $d == *'Failing repos:'* ]]; then
	d=$(expr $(grep 'Failing repos:' sync.log -n -m 1| cut -d ':' -f1) + 1)
	d2=$(expr $(grep 'Try re-running' sync.log -n -m1 | cut -d ':' -f1) - 1 )
	fail_paths=$(head -n $d2 sync.log | tail -n +$d)
	echo -e "d=$d \nd2=$d2 \nfail_paths=$fail_paths"
	for path in $fail_paths
	do
		rm -rf $path
		echo removed $path
		aa=$(echo $path|awk -F '/' '{print $NF}')
		rm -rf .repo/project-objects/*$aa.git .repo/projects/$path.git
		echo removed .repo/project-objects/*$aa.git .repo/projects/$path.git
	done
fi

if [[ $e == *'fatal: Unable'* ]]; then
	fail_paths=$(grep 'fatal: Unable' sync.log | cut -d ':' -f2 | cut -d "'" -f2)
	echo -e "fail_paths=$fail_paths"
	for path in $fail_paths
	do
		rm -rf $path
		echo removed $path
		aa=$(echo $path|awk -F '/' '{print $NF}')
		rm -rf .repo/project-objects/*$aa.git .repo/project-objects/$path.git .repo/projects/$path.git
		echo removed .repo/project-objects/*$aa.git .repo/project-objects/$path.git .repo/projects/$path.git
	done
fi

if [[ $f == *'error.GitError'* ]]; then
	rm -rf $(grep 'error.GitError' sync.log | cut -d ' ' -f2)
fi

if [[ $g == *'error: Cannot checkout'* ]]; then
	coerr=$(grep 'error: Cannot checkout' sync.log | cut -d ' ' -f 4| tr -d ':')
	echo -e "coerr=$coerr"
	for i in $coerr
	do
		rm -rf .repo/project-objects/$i.git
		echo removed .repo/project-objects/$i.git
	done
fi

if [[ $c == *'repo sync has finished'* ]]; then
	true
else
	repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
fi
rm -rf sync.log

dirty_dirs="prebuilts/clang/host/linux-x86"
for dir in $dirty_dirs
do
	[[ -n $(git -C "$dir" status -s) ]] && (rm -rf "$dir"; echo removed $dir; repo sync) || true
done
