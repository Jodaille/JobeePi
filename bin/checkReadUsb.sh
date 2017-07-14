#!/bin/bash
#
# Check that screen is running
#
# Should be run by crontab :
#
# */5 * * * * (. /etc/profile; /checkReadusb.sh > /dev/null)
#
# ~/bin/readLog.php

NOW=$(/bin/date +"%H:%M %d/%m/%Y")
#~/.profile
SCRIPT="/root/readUSB.sh"
#  screen /dev/ttyUSB0 9600
USER=jobee
readUSBCount=`ls -A -1 /var/run/screen/S-${USER} | grep readArduino | wc -l`
readScreen=`ls -A -1 /var/run/screen/S-${USER} | grep readArduino`

LOGFILE="/tmp/checkReadUSB.log"

echo $NOW read $readScreen >> $LOGFILE;

if [ $readUSBCount -ge 1 ]
then
  echo "Count is greater or equal than 1"
else
  echo $SHELL
  echo $NOW starting readArduino $readUSBCount $readScreen  >> $LOGFILE
	~/bin/readArduino.sh 
 # /usr/sbin/screen -Sdm readArduino -s $SCRIPT
  echo "launching screen readArduino"
fi


readLogCount=`ls -A -1 /var/run/screen/S-${USER} | grep readLog | wc -l`


if [ $readLogCount -ge 1 ]
then
  echo "Count readlog is greater or equal than 1"
else
  echo $SHELL
  echo $NOW starting readLog $readLogCount >> $LOGFILE
#        ~/bin/readLog.php
  /usr/bin/screen -Sdm readLog -s ~/bin/logToEmoncms.sh 

  echo "launching screen readLog"
fi

