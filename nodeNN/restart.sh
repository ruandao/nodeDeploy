#!/bin/sh -ex

serviceName=$(basename $1)
systemctl  restart rsyslog
systemctl restart game-${serviceName}
