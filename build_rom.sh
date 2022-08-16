set -e
set -x

# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/xdroid-oss/xd_manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/Sohang85/Local_Manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync

# build rom
. build/envsetup.sh
lunch xdroid_whyred-userdebug
make xd 

# upload rom

set -e

hash tar uname grep curl head
OS="$(uname)"
case $OS in
  Linux)
    OS='linux'
    ;;
  Darwin)
    OS='darwin'
    ;;
  *)
    echo 'OS not supported'
    exit 2
    ;;
esac

#check for beta flag
if [ -n "$1" ] && [ "$1" == "beta" ]; then
    echo "Warning: Beta version is unstable and prone to bugs and crashes."
    install_beta="beta "
fi

ARCH="$(uname -m)"
case $ARCH in
  x86_64|amd64)
    ARCH='amd64'
    ;;
  aarch64)
    ARCH='arm64'
    ;;
  i?86|x86)
    ARCH='386'
    ;;
  arm*)
    ARCH='arm'
    ;;
  *)
    echo 'OS type not supported'
    exit 2
    ;;
esac

if [ -z "${install_beta}" ]; then
  DOWNLOAD_URL=$(curl -fsSL https://api.github.com/repos/Mikubill/transfer/releases/latest | grep "browser_download_url.*$OS.*$ARCH" | cut -d '"' -f 4)
  curl -L "$DOWNLOAD_URL" | tar xz
else
  DOWNLOAD_URL=$(curl -fsSL https://api.github.com/repos/Mikubill/transfer/releases/43093978 | grep "browser_download_url.*$OS.*$ARCH" | cut -d '"' -f 4 | head -n 1)
  # DOWNLOAD_URL=$(curl -fsSL https://api.github.com/repos/Mikubill/transfer/releases | grep "browser_download_url.*$OS.*$ARCH" | cut -d '"' -f 4 | head -n 1)
  curl -Lo "transfer" "$DOWNLOAD_URL" 
  chmod a+x transfer
fi

printf "\nTransfer has successfully downloaded.\n"
exit 0

up out/target/product/whyred/*.zip
