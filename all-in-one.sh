#!/bin/env bash

if [ -z $1 ]; then
   echo "Usage: sync.sh [DISTRO]"
   exit 1
fi

OPTIONS="-rtlHq --delete-after --delay-updates --safe-links"
REPO="rsync://mirrors.kernel.org/"
DEST="/media/mirror/"
LCK_FILE="/tmp/rsync-mirror-$1"

# Make sure only 1 instance runs
if [ -e "$LCK_FILE" ]; then
   OTHER_PID=`cat $LCK_FILE`
   echo "Another instance already running: $OTHER_PID"
   exit 1
fi
echo $$ > "$LCK_FILE"

# Sync
echo "Syncing $1"
rsync $OPTIONS "$REPO/$1" "$DEST/$1"

# Cleanup
rm -f "$LCK_FLE"

exit 0
