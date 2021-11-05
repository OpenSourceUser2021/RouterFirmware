mkdir -p files/etc/uci-defaults/
cp ../scripts/init-settings.sh files/etc/uci-defaults/99-init-settings
mkdir -p files/etc/opkg
cp ../data/opkg/distfeeds.conf files/etc/opkg
mkdir -p files/www/snapshots
cp -r bin/targets files/www/snapshots
mkdir -p files/www/ipv6-modules
cp bin/packages/$PLATFORM/luci/luci-proto-ipv6* files/www/ipv6-modules
cp bin/packages/$PLATFORM/base/{ipv6helper*,odhcpd-ipv6only*,odhcp6c*,6in4*} "files/www/ipv6-modules"
cp bin/targets/$TARGET/$SUBTARGET/packages/{ip6tables*,kmod-nf-nat6*,kmod-ipt-nat6*,kmod-sit*,kmod-ip6tables-extra*} "files/www/ipv6-modules"
mkdir -p files/bin
cp ../scripts/ipv6-helper.sh files/bin/ipv6-helper
[ -e files ] && mv files openwrt/files
