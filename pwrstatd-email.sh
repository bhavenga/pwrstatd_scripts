#!/bin/bash
#
# This is script of the send mail for pwrstatd daemon that works with Ubuntu/Debian as the default Cyberpower script did not.
# All the cyberpower scripts can be found at http://www.cyberpowersystems.com/products/management-software/ppl.html
 
 
# If you want to change SMTP server, edit following parameters into /etc/mail.rc file.
# set smtp=smtp server address
# set smtp-auth-user=user name
# set smtp-auth-password=user password
 
 
SUBJECT="PowerPanel Notification - [$EVENT]"
FROM="PowerPanel Daemon <$SENDER_ADDRESS>"
TO="$RECEIPT_NAME <$RECEIPT_ADDRESS>"
MESSAGE="Warning: A $EVENT event has occurred!"
 
DATE=`date +'%Y/%m/%d %p %H:%M'`
test ${#DATE}

REMAINING_RUNTIME=$(pwrstat -status  |grep Remaining | awk ' { print $3 } ')
MODEL_NAME=$(pwrstat -status  |grep Model | awk ' { print $3 } ')
BATTERY_CAPACITY=$(pwrstat -status  |grep Battery | awk ' { print $3 } ') 

RUNTIME="Remaining Runtime: $REMAINING_RUNTIME minutes"
 
DATA=(
"========================================================"
"   $SUBJECT"
"========================================================"
""
""
"$MESSAGE"
"Time: $DATE"
""
""
"UPS Model Name: $MODEL_NAME"
"Battery Capacity: $BATTERY_CAPACITY %"
"$RUNTIME"
)
 
IFS=$'\n'
echo "${DATA[*]}" | mail \
-r   "$FROM" \
-s   "$SUBJECT" \
     "$TO"
 
exit 0