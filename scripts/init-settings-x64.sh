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
# uci set network.lan.proto='static'
# uci set network.lan.ipaddr='192.168.1.250'
# uci set network.lan.gateway='192.168.1.1'
# uci set network.lan.dns='192.168.1.1'
# uci set dhcp.lan.ignore='1'
uci set network.wan.device='eth0'
uci set network.wan6.device='eth0'

uci del_list network.@device[0].ports='eth0'
uci del_list network.@device[0].ports='eth1'
uci del_list network.@device[0].ports='eth2'
uci del_list network.@device[0].ports='eth3'
uci del_list network.@device[0].ports='eth4'
uci del_list network.@device[0].ports='eth5'
uci del_list network.@device[0].ports='eth6'
uci del_list network.@device[0].ports='eth7'

uci add_list network.@device[0].ports='eth1'
uci add_list network.@device[0].ports='eth2'
uci add_list network.@device[0].ports='eth3'
uci add_list network.@device[0].ports='eth4'
uci add_list network.@device[0].ports='eth5'
uci add_list network.@device[0].ports='eth6'
uci add_list network.@device[0].ports='eth7'

# login TTYD w/o password
uci set ttyd.@ttyd[0].command='/bin/login -f root'
# steven <-

# Check file system during boot
uci set fstab.@global[0].check_fs=1
uci commit

# Disable opkg signature check
sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf

# steven ->
cp -r /usr/share/openclash/yacd/ /usr/share/openclash/dashboard/

# fix system log issue "daemon.err modprobe: - bpfilter"
# cd /lib/modules/5.*/
# mv bpfilter.ko bpfilter.ko.bak

# Disable IPV6 ula prefix
sed -i 's/^[^#].*option ula/#&/' /etc/config/network
# steven <-

# Disable autostart by default for some packages
cd /etc/rc.d
rm -f S98udptools || true

exit 0
