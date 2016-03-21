#!/bin/bash
# Runs local Protractor tests via docker-frontend-container (for docker-machine)

docker pull leanix/docker-frontend-framework:latest

# Workaround on OSX to prevent b2d-sync's unmounting of `/Users` in VM
hostPath=$PWD
if [[ $hostPath == "/Users/"* ]]; then
  docker-machine ssh default "if [[ -z \"\$(grep '/mnt/ffUsers' /proc/mounts)\" ]]; then \
      sudo mkdir -p /mnt/ffUsers; \
      sudo mount -v -t vboxsf -o 'defaults,iocharset=utf8' Users /mnt/ffUsers;
    fi";
  hostPath=/mnt/ff${hostPath:1};
fi

# Run container with current working directory mounted to /ff/host
ip=$(docker-machine ip default)
script="cd ff && xvfb-run -a protractor host/protractor.conf.js --globalPhantomJS $@" # Use $script to avoid (unexpected) truncation of arguments below
docker run -i --rm="true" -v "$hostPath:/ff/host" --add-host="local-eam.leanix.net:$ip" \
  --add-host="local-svc.leanix.net:$ip" leanix/docker-frontend-framework:latest \
  bash -c "$script"
