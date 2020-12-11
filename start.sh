#!/bin/bash

RADARR_DIR=$(ls | grep Radarr*)

/opt/$RADARR_DIR/Radarr -nobrowser -data=/config
