#!/bin/bash

RADARR_DIR=$(ls | grep Radarr*)

if [ $ENABLE_BACKUP = "1" ]; then
  /app/sonarr/bin/backup.sh &
fi

/opt/$RADARR_DIR/Radarr -nobrowser -data=/config
