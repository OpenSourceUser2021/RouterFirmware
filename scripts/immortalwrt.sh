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
sudo -E apt-get -qq install libfuse-dev
rm -rf feeds/packages/lang/golang
git clone --depth 1 https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

#wechatpush
rm -rf feeds/luci/applications/luci-app-wechatpush
git clone --depth 1 https://github.com/tty228/luci-app-wechatpush.git package/custom/luci-app-wechatpush


# use official openclash source
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth 1 https://github.com/vernesong/OpenClash.git package/custom/luci-app-openclash


# fix linux kernel 6.6.x udp issue
rm -rf target/linux/generic/hack-6.6/600-net-enable-fraglist-GRO-by-default.patch
rm -rf target/linux/generic/pending-6.6/680-net-add-TCP-fraglist-GRO-support.patch
rm -rf target/linux/generic/pending-6.6/681-net-remove-NETIF_F_GSO_FRAGLIST-from-NETIF_F_GSO_SOF.patch
rm -rf target/linux/generic/backport-6.6/611-01-v6.11-udp-Allow-GSO-transmit-from-devices-with-no-checksum.patch
rm -rf target/linux/generic/backport-6.6/611-02-v6.11-net-Make-USO-depend-on-CSUM-offload.patch
rm -rf target/linux/generic/backport-6.6/611-03-v6.11-udp-Fall-back-to-software-USO-if-IPv6-extension-head.patch

# Rename hostname to OpenWrt
#pushd package/base-files/files/bin
#sed -i 's/ImmortalWrt/OpenWrt/g' config_generate
#popd

# update MT76 driver 
# link https://github.com/immortalwrt/immortalwrt/blob/master/package/kernel/mt76/Makefile
#sed -i "s/2024-04-03/2024-07-13/g" package/kernel/mt76/Makefile
#sed -i "s/1e336a8582dce2ef32ddd440d423e9afef961e71/3b47d9df427c4833605a172f2a8f0e0012b04c80/g" package/kernel/mt76/Makefile
#sed -i "s/48e787bcf0c526d9511375a8a3a77c850de9deca79f6177d2eeea7ca8bd798e2/23c3aaa53fb2e088446eb18148a44d3edcd3a0eda1ee41cf5cbf56064ebbee58/g" package/kernel/mt76/Makefile


# Change default shell to zsh
#-- sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd
# Change default shell from /bin/ash to /bin/bash
sed -i 's/\/bin\/ash/\/bin\/bash/g' package/base-files/files/etc/passwd
# steven <-
