#!/bin/bash
AUTOBUILD="/opt/autobuild/bin/autobuild"
ARCH="64"
CHAN="Bunnybuild"
CONFIG="ReleaseFS_open"

if [ -n "$1" ]; then
  CHAN=$1
fi

CONFIGURE_CMD="$AUTOBUILD -m$ARCH -c $CONFIG -- --clean -DLL_TESTS:BOOL=FALSE"
BUILD_CMD="$AUTOBUILD -m$ARCH build -c $CONFIG -- --chan $CHAN"

eval "$CONFIGURE_CMD"
eval "$BUILD_CMD"
