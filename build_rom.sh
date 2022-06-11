# sync rom
repo init -u https://github.com/syberia-project/manifest.git -b 12.1
https://github.com/syberia-project/manifest.git -b 12.1
repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) --optimized-fetch --prune

# build rom
cd <ASUS_X00TD>
<X00TD>
git add -A
git commit -m "commit message"
git push ssh://<SKetU-l>@gerrit.syberiaos.com:29418/syberia-X00TD/<X00TD> HEAD:refs/for/12.0

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
