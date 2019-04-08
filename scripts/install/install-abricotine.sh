#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

ABRICOTINE_INSTALL="$HOME/bin/abricotine"

mkdir -p $ABRICOTINE_INSTALL

cd $ABRICOTINE_INSTALL

echo "Downloading from GitHub releases Abricotine v$ABRICOTINE_VERSION"
wget -qO- "https://github.com/brrd/Abricotine/archive/$ABRICOTINE_VERSION.tar.gz" | tar --extract --verbose --gzip --strip 1

yarn install --production
