#!/bin/sh
echo "Warning: Utility power has failed. System may shutdown soon!" | wall

export RECEIPT_NAME
export RECEIPT_ADDRESS
export SENDER_ADDRESS
export EVENT

EVENT="Power Failure"


# If you want to receive event notification by e-mail, you must change 'ENABLE_EMAIL' item to 'yes'.
# Note: After change 'ENABLE_EMAIL' item, you must asign 'RECEIPT_NAME', 'RECEIPT_ADDRESS', and 
# 'SENDER_ADDRESS' three items as below for the correct information.
#

# Enable to send e-mail
ENABLE_EMAIL=yes

# Change your name at this itme.
RECEIPT_NAME="Barend Havenga"

# Change mail receiver address at this itme.
RECEIPT_ADDRESS=barend.havenga@gmail.com

# Change mail sender address at this itme.
SENDER_ADDRESS=havengacams@gmail.com

# Execute the 'pwrstatd-email.sh' shell script
if [ $ENABLE_EMAIL = yes ]; then
   /etc/pwrstatd-email.sh
fi
