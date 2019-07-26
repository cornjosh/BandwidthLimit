#!/bin/bash
#auth:zylntxx

clear
echo "##########################################"
echo "#       Ucloud服务优化一键脚本            ##"
echo "#       请使用root权限运行                ##"
echo "##########################################"
if [ -f "/usr/bin/apt-get" ];then
	apt-get update && apt-get -y install git make;
else
	yum -y -t install git make;
fi
cd ~
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
make install
dir=`which wondershaper`
if [ $dir ！= "/usr/bin/wondershaper" ];then
	echo "#############################"
	echo "安装异常，请稍后再试"
	exit 1;
fi
systemctl enable wondershaper.service
eth=`ls /sys/class/net | grep -v lo | head -1`
sed -i "/IFACE/c IFACE="$eth"" /etc/conf.d/wondershaper.conf
sed -i '/DSPEED/c DSPEED="286720"' /etc/conf.d/wondershaper.conf
sed -i '/USPEED/c USPEED="286720"' /etc/conf.d/wondershaper.conf
wondershaper -a $eth -d 286720 -u 286720
cd ~
rm -rf wondershaper
echo "#################################"
echo "安装完成"
