#!/bin/bash

RADARR_DIR=$(ls | grep Radarr*)

mono --debug /opt/$RADARR_DIR/NzbDrone.exe -nobrowser -data=/config
