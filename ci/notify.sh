#!/usr/bin/env bash

rom_name=$(grep 'repo init' $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
branch_name=$(grep 'repo init' $CIRRUS_WORKING_DIR/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
only_rom=$rom_name
rom_name=$rom_name-$branch_name
device=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
grep _jasmine_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=jasmine_sprout
grep _laurel_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=laurel_sprout
grep _GM8_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=GM8_sprout
grep _SCW_sprout $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=SCW_sprout
grep _maple_dsds $CIRRUS_WORKING_DIR/build_rom.sh > /dev/null && device=maple_dsds
your_telegram_id=@ROM_builders_junk
show=$(cat $CIRRUS_WORKING_DIR/build_rom.sh)
curl -s "https://api.telegram.org/bot${bot_api}/sendmessage" -d "text=<code>$device-$rom_name</code> Started
https://cirrus-ci.com/build/$CIRRUS_BUILD_ID $show" -d "chat_id=${your_telegram_id}" -d "parse_mode=HTML"

github_userid=$(gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repos/ROM-builders/temporary/commits/$CIRRUS_CHANGE_IN_REPO -q '.author.id')
github_username=$(gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repos/ROM-builders/temporary/commits/$CIRRUS_CHANGE_IN_REPO -q '.author.login')
triggered_date=$(date +%s)
if [[ $BRANCH == *pull/* ]]; then CIRRUS_COMMIT_MESSAGE="" ; fi
curl -X POST "$two" -H "apikey: $three" -H "Authorization: Bearer $four" -H "Content-Type: application/json" -H "Prefer: return=minimal" -d "{ \"github_userid\": \"$github_userid\", \"github_username\": \"$github_username\", \"triggered_date\": \"$triggered_date\", \"branch\": \"$BRANCH\", \"cirrus_build_id\": \"https://cirrus-ci.com/build/$CIRRUS_BUILD_ID\", \"cirrus_task_id\": \"https://cirrus-ci.com/task/$CIRRUS_TASK_ID\", \"cirrus_last_green_build_id\": \"https://cirrus-ci.com/build/$CIRRUS_LAST_GREEN_BUILD_ID\", \"cirrus_commit_message\": \"$CIRRUS_COMMIT_MESSAGE\", \"rom_name\": \"$only_rom\", \"rom_branch\": \"$branch_name\", \"device\": \"$device\" }"
