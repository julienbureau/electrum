#!/bin/bash
set -ev

BUILD_REPO_URL=https://github.com/archos-safe-t/electrum.git

sudo rm electrum-dash -rf

git clone --branch archos-releases-dash $BUILD_REPO_URL electrum-dash

docker run --rm \
    -v $(pwd):/opt \
    -w /opt/electrum-dash \
    -t zebralucky/electrum-dash-winebuild:Linux /opt/build_linux.sh

sudo find . -name '*.po' -delete
sudo find . -name '*.pot' -delete

export WINEARCH=win32
export WINEPREFIX=/root/.wine-32
export PYHOME=$WINEPREFIX/drive_c/Python34

wget https://github.com/zebra-lucky/zbarw/releases/download/20180620/zbarw-zbarcam-0.10-win32.zip
unzip zbarw-zbarcam-0.10-win32.zip && rm zbarw-zbarcam-0.10-win32.zip

docker run --rm \
    -e WINEARCH=$WINEARCH \
    -e WINEPREFIX=$WINEPREFIX \
    -e PYHOME=$PYHOME \
    -v $(pwd):/opt \
    -v $(pwd)/electrum-dash/:$WINEPREFIX/drive_c/electrum-dash \
    -w /opt/electrum-dash \
    -t zebralucky/electrum-dash-winebuild:Wine /opt/build_wine.sh

export WINEARCH=win64
export WINEPREFIX=/root/.wine-64
export PYHOME=$WINEPREFIX/drive_c/Python34

wget https://github.com/zebra-lucky/zbarw/releases/download/20180620/zbarw-zbarcam-0.10-win64.zip
unzip zbarw-zbarcam-0.10-win64.zip && rm zbarw-zbarcam-0.10-win64.zip

docker run --rm \
    -e WINEARCH=$WINEARCH \
    -e WINEPREFIX=$WINEPREFIX \
    -e PYHOME=$PYHOME \
    -v $(pwd):/opt \
    -v $(pwd)/electrum-dash/:$WINEPREFIX/drive_c/electrum-dash \
    -w /opt/electrum-dash \
    -t zebralucky/electrum-dash-winebuild:Wine /opt/build_wine.sh
