#!/bin/env bash

if [ -z $1 ]; then
   echo "Usage: sync.sh [DISTRO]"
   exit 1
fi

OPTIONS="-rtlHqv --delete-after --delay-updates --safe-links"
REPO="rsync://mirrors.kernel.org/$1"
DEST="/media/mirror/$1"
LCK_FILE="/tmp/rsync-mirror-$1.lck"
LOG_FILE="/tmp/log-$1.log"

# Make sure only 1 instance runs
if [ -e "$LCK_FILE" ]; then
   OTHER_PID=`cat $LCK_FILE`
   echo "Another instance already running: $OTHER_PID"
   exit 1
fi
echo $$ > "$LCK_FILE"

# Sync
rsync $OPTIONS $REPO $DEST &> $LOG_FILE

# Cleanup
rm -f "$LCK_FLE"

exit 0
