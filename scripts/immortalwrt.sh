#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Mod zzz-default-settings
pushd package/emortal/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/openwrt_luci/d' zzz-default-settings
popd

# Add date version
export DATE_VERSION=$(date -d "$(rdate -n -4 -p pool.ntp.org)" +'%Y-%m-%d')
sed -i "s/%C/%C (${DATE_VERSION})/g" package/base-files/files/etc/openwrt_release


rm -rf package/custom; 
mkdir package/custom
# Add luci-app-oaf
git clone --depth=1 https://github.com/destan19/OpenAppFilter package/custom/OpenAppFilter
#popd

# koolproxy
#git clone --depth 1 https://github.com/1wrt/luci-app-ikoolproxy.git package/luci-app-ikoolproxy

# homeroxy
# git clone --depth 1 https://github.com/immortalwrt/homeproxy.git package/luci-app-homeproxy

# alist
rm -rf feeds/packages/net/alist
rm -rf feeds/luci/applications/luci-app-alist
git clone --depth 1 https://github.com/sbwml/openwrt-alist.git package/custom/luci-app-alist
# fix alist build fail issue -> https://github.com/sbwml/luci-app-alist
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang

#wechatpush
rm -rf feeds/luci/applications/luci-app-wechatpush
git clone --depth 1 https://github.com/tty228/luci-app-wechatpush.git package/custom/luci-app-wechatpush


# use official openclash source
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth 1 https://github.com/vernesong/OpenClash.git package/custom/luci-app-openclash


# Rename hostname to OpenWrt
#pushd package/base-files/files/bin
#sed -i 's/ImmortalWrt/OpenWrt/g' config_generate
#popd


# Change default shell to zsh
#-- sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd
# Change default shell from /bin/ash to /bin/bash
sed -i 's/\/bin\/ash/\/bin\/bash/g' package/base-files/files/etc/passwd
# steven <-
