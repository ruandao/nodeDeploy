#!/bin/sh -ex

if [ $# -lt 1 ];then
    echo "请输入要部署的目录的绝对路径"
    echo "usage: ./init.sh /root/directory"
    exit
fi

ws=$1
mkdir -p ~/bin

cd $ws

serviceName=$(basename $ws)

# 配置服务
sudo sed -e "s/DIRNAME/${serviceName}/g" template/template.service > /usr/lib/systemd/system/game-${serviceName}.service
# 配置日志服务
sudo sed -e "s/DIRNAME/${serviceName}/g" template/template.rsyslog.conf > /etc/rsyslog.d/game-${serviceName}.conf
# 配置日志转存
sudo sed -e "s/DIRNAME/${serviceName}/g" template/template.logrotate.conf > /etc/logrotate.d/game-${serviceName}.logrotate.conf
cat /usr/lib/systemd/system/game-${serviceName}.service
cat /etc/rsyslog.d/game-${serviceName}.conf
cat /etc/logrotate.d/game-${serviceName}.logrotate.conf

echo "enable game-${serviceName}"
systemctl enable game-${serviceName}

./restart.sh $ws

echo "end init"

