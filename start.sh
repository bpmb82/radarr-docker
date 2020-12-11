#!/bin/bash

RADARR_DIR=$(ls | grep Radarr*)

mono --debug /opt/$RADARR_DIR/Radarr -nobrowser -data=/config
