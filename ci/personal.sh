#!/usr/bin/env bash

set -e
your_telegram_id=@buildseartinity
curl -s "https://api.telegram.org/bot${${{secrets.BOT_TOKEN}}}/sendmessage" -d "text=<code>$device-$rom_name</code> has been succeeded!
https://cirrus-ci.com/build/$CIRRUS_BUILD_ID" -d "chat_id=${your_telegram_id}" -d "parse_mode=HTML"
