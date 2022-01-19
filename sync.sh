#!/bin/bash

# Change to the Home Directory
cd ~

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" -d chat_id="${TG_CHAT_ID}" \
	-d text="$1"
}

# Change to the directory where we'll sync the source
mkdir -p $SYNC_PATH
cd $SYNC_PATH

# Init repo
repo init --depth=1 -u $MANIFEST -b $MANIFEST_BRANCH

# Sync
repo sync --force-sync -j$(nproc --all) --no-tags --no-clone-bundle

# Clone Trees
git clone $DT_LINK $DT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }

# Exit
exit 0
