# function to upload Rom zip on Telegram
tg_upload_rom () {
    zip="out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip"
    rom_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d / -f 4)
    branch_name=$(grep init $CIRRUS_WORKING_DIR/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
    device=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
    curl -F document=@"$zip" "https://api.telegram.org/bot$TG_TOKEN/sendDocument" \
        -F chat_id="$TG_CHAT_ID" \
        -F caption="$device-$rom_name-$branch_name"
}

# upload zip
tg_upload_rom
