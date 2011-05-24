#!/bin/bash

OPTIONS="-rtlHqv --delete-after --delay-updates --safe-links"
REPO="rsync://mirrors.kernel.org/$1"
DEST="/media/mirror/$1"
LCK_FLE="/var/lock/mirror/$1.lck"
LOG_FLE="/var/log/mirror/$1.log"

# Check for arguments
if [ -z $1 ]; then
   echo "Usage: sync.sh [DISTRO]"
   exit 1
fi

# Make sure only 1 instance runs
if [ -e "$LCK_FLE" ]; then
   OTHER_PID=`cat $LCK_FLE`
   echo "Another instance already running: $OTHER_PID" > $LOG_FLE 
   exit 1
fi
echo $$ > "$LCK_FLE"

# Sync
rsync $OPTIONS $REPO $DEST &> $LOG_FLE

# Cleanup
rm -f "$LCK_FLE"

exit 0
