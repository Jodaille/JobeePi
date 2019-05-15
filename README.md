# JobeePi

backup of scripts used on RPi that was monitoring Beehive (Danvou)

- bin/audio_analyse.sh
  generate an image from an audio record

- bin/audio_record.sh
  record audio from USB sound card (call via crontab)

- bin/checkReadUsb.sh
  check GNU screen instance is up (named "readLog"), if not (re)launch it
  running ~/bin/logToEmoncms.sh 

- bin/logToEmoncms.sh
  pipe GNU screen log to ~/bin/readLog.php
  screen has log into file activate, the arduino serial is open whith screen

- bin/readLog.php
  parse GNU screen log to extract sensors data values and send (JSON) to remote emoncms (https://emoncms.org/)

- bin/snap.sh
  fetch image from IP camera and send it to remote server (scp)
  
