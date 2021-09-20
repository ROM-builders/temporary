#!/bin/bash
set -e
rom_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
branch_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
if [[ $rom_name == LineageOS ]]; then if [[ $branch_name == lineage-17.1 ]]; then rom_name=$rom_name-$branch_name; fi; fi
if [[ $rom_name == LineageOS ]]; then if [[ $branch_name == lineage-15.1 ]]; then rom_name=$rom_name-$branch_name; fi; fi
mkdir -p ~/roms/$rom_name
cd ~/roms/$rom_name
rm -rf .repo/local_manifests
command=$(head $CIRRUS_WORKING_DIR/build_rom.sh -n $(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1))
only_sync=$(grep 'repo sync' $CIRRUS_WORKING_DIR/build_rom.sh)
(bash -c "$command" | tee sync.txt) || (grep '^fatal: remove-project element specifies non-existent project' sync.txt && exit 1) || \
(grep 'uncommitted changes are present.$' sync.txt | awk -F ': ' '{print $2}' > uncommited.txt \
&& while IFS= read -r line; do rm -rf "$line/.git"; done < uncommited.txt && exit 1)  || \
(repo forall -c 'git checkout .' && bash -c "$only_sync") || (find -name shallow.lock -delete && find -name index.lock -delete && bash -c "$only_sync")
rm -rf sync.txt
