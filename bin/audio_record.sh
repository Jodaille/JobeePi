#!/bin/bash

ARDUINOLOG="/home/jobee/screen.log"
RECORDPATH="/media/sda1/recordings"
RECORDFILENAME=`date +%Y-%m-%d-%H%M%S`
RECORDFILEPATH="$RECORDPATH/$RECORDFILENAME.wav"
THRESHOLD=10

#echo $IMAGENAME

LUX=`tail -1 $ARDUINOLOG | awk -F ";" '{print $2}' | awk -F "=" '{print $2}'`

#echo Lux: $LUX THRESHOLD: $THRESHOLD


if (( $(echo "$THRESHOLD $LUX" | awk '{print ($1 <= $2)}') )); 
then
#	echo RECORDFILEPATH $RECORDFILEPATH

	arecord -f S16_LE -d59 -r 44100 -D hw:1,0 -c 2 $RECORDFILEPATH

fi

