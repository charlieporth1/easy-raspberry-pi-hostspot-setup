#!/bin/bash
SETUP_FILES_DIR=$PWD
cd $INSTALL_FILES_DIR
CONFIG_INSTALL_DIR=/etc
BIN_INSTALL_DIR=/usr/local/bin

#install packages
sudo apt update

if [[ -z `which hostapd` ]]; then
	sudo apt install -y hostapd
fi
if [[ -z `which dnsmasq` ]]; then
	sudo apt install -y dnsmasq
fi
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
#DNMSAQ BK
sudo cp -rf $CONFIG_INSTALL_DIR/dhcpcd.conf $CONFIG_INSTALL_DIR/dhcpcd.conf.bk $CONFIG_INSTALL_DIR/dhcpcd.conf.bk.org
cp -rf $SETUP_FILES_DIR/sysctl.d/* $CONFIG_INSTALL_DIR/sysctl.d/
cp -rf $SETUP_FILES_DIR/dnsmasq/* $CONFIG_INSTALL_DIR/dnsmasq.d/
cp -rf $SETUP_FILES_DIR/hostapd/* $CONFIG_INSTALL_DIR/hostapd/
chmod 777 ./*.sh
ln -s $SETUP_FILES_DIR/start_ap.sh $BIN_INSTALL_DIR
echo "start_ap.sh" >> /etc/rc.local

