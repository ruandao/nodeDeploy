#!/bin/sh -ex

if [ $# -lt 3 ];then
    echo "usage: ./publish ser /path/to/binary /root/directory"
    exit
fi

ser=$1
binaryFile=$2
targetDirectory=$3
serviceName=$(basename $3)
deployTime=`date +"%Y-%m-%d_%H:%M:%S"`


scp $binaryFile $ser:bin/${serviceName}.${deployTime}
ssh $ser chmod a+x bin/${serviceName}.${deployTime}
ssh $ser rm -rf $targetDirectory/node
ssh $ser ln -s /root/bin/${serviceName}.${deployTime} $3/node
