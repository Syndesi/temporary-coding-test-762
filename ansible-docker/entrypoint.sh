#!/bin/sh

if [ -d "/ssh-volume" ]; then
    mkdir -p /root/.ssh
    cp -R /ssh-volume/* /root/.ssh/
    chown -R root:root /root/.ssh
fi

exec "$@"
