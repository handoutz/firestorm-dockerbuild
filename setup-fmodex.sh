#!/bin/bash
AUTOBUILD="/opt/autobuild/bin/autobuild"
ARCHIVE=`ls /opt/fmodex/ | grep tar.bz2 | grep -m1 fmodex-44461-linux-` 
MD5SUM=($(md5sum /opt/fmodex/$ARCHIVE))
echo "MD5SUM of fmodex-archive $ARCHIVE: $MD5SUM"

$AUTOBUILD installables edit fmodex platform=linux hash=$MD5SUM url=file:///opt/fmodex/$ARCHIVE
exit
