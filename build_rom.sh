export CCACHE_DIR=/home/amogus/cache
mkdir -p /home/amogus/cache
wu='https://discord.com/api/webhooks/1017821133959077978/fYenpQNVuMZEfm9G5nctsH7prarMgNZA-l_J7eti5HvQJkG2PEKicaY3Qs3uFhMMuSju'

# sync rom
repo init -u https://github.com/LineageOS/android.git -b lineage-19.1
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_alioth-userdebug
export TZ=Asia/Dhaka #put before last build command
make bacon

zip amogus.zip -r /home/amogus/cache
amogus="$(wget --method PUT --body-file=amogus.zip https://transfer.sh/amogus.zip -O - -nv)"
wget https://raw.githubusercontent.com/ChaoticWeg/discord.sh/master/discord.sh && chmod +x discord.sh
./discord.sh --webhook-url $wu --text "<:dnd:546871193282674703> impostor detected. $amogus"

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
