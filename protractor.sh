#!/bin/bash
# Runs local Protractor tests via docker-frontend-container
script="cd ff && protractor host/protractor.conf.js --globalPhantomJS $@" # Use $script to avoid (unexpected) truncation of arguments below
docker run -it --rm="true" -v "$PWD:/ff/host" --add-host="local-eam.leanix.net:192.168.59.103" \
  --add-host="local-svc.leanix.net:192.168.59.103" leanix/docker-frontend-framework:latest \
  bash -c "$script"
