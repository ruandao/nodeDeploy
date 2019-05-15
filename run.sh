#!/bin/sh -ex

echo "start scp"
scp -r nodeNN ser4:

echo "start init"
ssh ser4 ./nodeNN/init.sh /root/nodeNN

./nodeNN/publish.sh ser4 ./nodeNN/node /root/nodeNN/


ssh ser4 ./nodeNN/restart.sh /root/nodeNN
