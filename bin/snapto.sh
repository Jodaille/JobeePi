#!/bin/bash

IPCAMERA="192.168.1.130"
ARDUINOLOG="/home/jobee/screen.log"
IMAGEPATH="/home/jobee/imgmonitor"
TMPIMAGENAME="/snap.jpg"
IMAGENAME=`date +%Y-%m-%d-%H%M%S`
TMPIMGPATH="$IMAGEPATH/$IMAGENAME.jpg"
THRESHOLD=10

echo $IMAGENAME

LUX=`tail -1 $ARDUINOLOG | awk -F ";" '{print $2}' | awk -F "=" '{print $2}'`

echo Lux: $LUX THRESHOLD: $THRESHOLD


if (( $(echo "$THRESHOLD $LUX" | awk '{print ($1 <= $2)}') )); 
then
	echo "Lux: $LUX <  $THRESHOLD"
	echo TMPIMGPATH $TMPIMGPATH
	wget -q http://admin:admin@$IPCAMERA/tmpfs/snap.jpg -O $TMPIMGPATH

fi

