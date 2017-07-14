#!/bin/bash

FILENAME=$1
NORMALIZED=${FILENAME/.wav/_mono.wav}

echo processing: $FILENAME

#echo sox $FILENAME $NORMALIZED remix 1,2 norm -3 sinc 30-1500 rate 3000
sox $FILENAME $NORMALIZED remix 1,2 norm -3 sinc 30-1500 rate 3000
echo $NORMALIZED


sox $NORMALIZED -n spectrogram -h -m -p 3 -z 85 -y 768 -o $NORMALIZED-spectrogram.png
echo $NORMALIZED-spectrogram.png

sox $NORMALIZED -n stat -freq 2>&1 | sed -n -e :a -e '1,15!{P;N;D;};N;ba' | xvfb-run gnuplot -e "set terminal png size 800,600 enhanced font 'Helvetica,10'; set output '$NORMALIZED-power.png'; set xtics 100; set ytics 1000; set yrange [1:15000]; plot '-' with impulses"
echo $NORMALIZED-power.png

rm $FILENAME

