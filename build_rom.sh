# sync rom
git clone https://github.com/phhusson/treble_experimentations

# build rom
mkdir AOSP11; cd AOSP11
bash ../treble_experimentations/build.sh android-11.0

# upload rom
rclone copy out/target/product/mido/*.zip cirrus:mido -P
