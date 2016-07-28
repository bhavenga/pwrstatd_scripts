#!/bin/bash
#
# Updated CyperPower email script as created/edited by Barend Havenga. 
# If you're using a residential internet connection, you may need to configure ssmtp to relay your email messages.
# 	See: http://www.cyberciti.biz/tips/linux-use-gmail-as-a-smarthost.html
# All the cyberpower scripts can be found at http://www.cyberpowersystems.com/products/management-software/ppl.html
 
 
# If you want to change SMTP server, edit following parameters into /etc/mail.rc file.
# set smtp=smtp server address
# set smtp-auth-user=user name
# set smtp-auth-password=user password
 
 
SUBJECT="PowerPanel Notification - [$EVENT]"
FROM="PowerPanel Daemon <$SENDER_ADDRESS>"
TO="$RECEIPT_NAME <$RECEIPT_ADDRESS>"
MESSAGE="Warning: A $EVENT event has occurred!"
 
DATE=`date +'%Y/%m/%d %H:%M %p'`
test ${#DATE}

REMAINING_RUNTIME=$(pwrstat -status  |grep Remaining | awk ' { print $3 } ')
MODEL_NAME=$(pwrstat -status  |grep Model | awk ' { print $3 } ')
BATTERY_CAPACITY=$(pwrstat -status  |grep Capacity | awk ' { print $3 } ') 
PWR_EVENT=$(pwrstat -status  |grep "Power Event" | awk ' { print $4,$5,$6,$7} ') 
LOAD=$(pwrstat -status  |grep "Load" | awk ' { print $2,$3,$4 } ') 

RUNTIME="Remaining Runtime: $REMAINING_RUNTIME minutes"
 
DATA=(
"========================================================"
"   $SUBJECT"
"========================================================"
""
""
"$MESSAGE"
"Current Time: $DATE"
""
""
"UPS Model Name: $MODEL_NAME"
"UPS Location: Home - NAS"
"$RUNTIME"
"Battery Capacity: $BATTERY_CAPACITY %"
"UPS Load: $LOAD"
"Last power event: $PWR_EVENT"
)
 
IFS=$'\n'
echo "${DATA[*]}" | mail \
-r   "$FROM" \
-s   "$SUBJECT" \
     "$TO"
 
exit 0
