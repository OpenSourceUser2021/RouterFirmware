#!/bin/bash
#=================================================
# File name: init-settings.sh
# Description: This script will be executed during the first boot
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================

# Set default theme to luci-theme-argon
uci set luci.main.mediaurlbase='/luci-static/argon'

# steven ->
# Set language to zh_cn
uci set luci.main.lang='zh_cn'

# set static lan and disable DHCP on lan
uci set network.lan.proto='static'
uci set network.lan.ipaddr='192.168.1.250'
uci set network.lan.gateway='192.168.1.1'
uci set network.lan.dns='192.168.1.1'
uci set dhcp.lan.ignore='1'
# steven <-

# Check file system during boot
uci set fstab.@global[0].check_fs=1
uci commit

# Disable opkg signature check
sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf

# steven ->
# login TTYD w/o password
sed -i 's/\/bin\/login/\/bin\/login -f root/' /etc/config/ttyd
cp -r /usr/share/openclash/yacd/ /usr/share/openclash/dashboard/

# fix system log issue "daemon.err modprobe: - bpfilter"
cd /lib/modules/5.*/
mv bpfilter.ko bpfilter.ko.bak

# Disable IPV6 ula prefix
sed -i 's/^[^#].*option ula/#&/' /etc/config/network
# steven <-

# Disable autostart by default for some packages
cd /etc/rc.d
rm -f S98udptools || true

exit 0
