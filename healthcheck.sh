#!/bin/bash

FILE=/config/config.xml

until test -f $FILE; do sleep 1; done

API=$(xml_grep --text_only 'ApiKey' $FILE)
curl -f "http://localhost:7878/api/v3/system/status?apikey=$API" && curl api.ipify.org || exit 1
