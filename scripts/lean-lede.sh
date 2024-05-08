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

# Clone community packages to package/community
mkdir package/community
pushd package/community
# Add luci-app-oaf
#-- git clone --depth=1 https://github.com/destan19/OpenAppFilter -b oaf-3.0.1
popd

# Add luci-app-amlogic
#-- svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic

# aliyundrive webdav
git clone --depth 1 https://github.com/jerrykuku/go-aliyundrive-webdav.git package/go-aliyundrive-webdav
git clone --depth 1 https://github.com/jerrykuku/luci-app-go-aliyundrive-webdav.git package/luci-app-go-aliyundrive-webdav
#svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav package/aliyundrive-webdav
#svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav package/luci-app-aliyundrive-webdav

# koolproxy
git clone --depth 1 https://github.com/1wrt/luci-app-ikoolproxy.git package/luci-app-ikoolproxy

# homeroxy
# git clone --depth 1 https://github.com/immortalwrt/homeproxy.git package/luci-app-homeproxy

# alist
rm -rf package/luci-app-alist
rm -rf feeds/luci/applications/luci-app-alist
git clone --depth 1 https://github.com/sbwml/openwrt-alist.git package/luci-app-alist
# fix alist build fail issue -> https://github.com/sbwml/luci-app-alist
#rm -rf feeds/packages/lang/golang
#svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang


#rm -rf package/luci-app-homeproxy
#rm -rf feeds/luci/applications/luci-app-homeproxy
#git clone --depth 1 https://github.com/douglarek/luci-app-homeproxy.git package/luci-app-homeproxy

# use official openclash source
rm -rf package/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-openclash
#svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
git clone --depth 1 https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# luci-app-timecontrol
rm -rf package/luci-app-timecontrol
rm -rf feeds/luci/applications/luci-app-timecontrol
#-- 23.05 svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-timecontrol package/luci-app-timecontrol
git clone --depth 1 --filter=tree:0 https://github.com/Lienol/openwrt-package package/luci-app-timecontrol
cd package/luci-app-timecontrol
git sparse-checkout set --no-cone luci-app-timecontrol
git checkout
cd ../..

# Rename hostname to OpenWrt
#pushd package/base-files/files/bin
#sed -i 's/ImmortalWrt/OpenWrt/g' config_generate
#popd

rm -rf feeds/packages/utils/apk

# steven ->
# Fix Toolchain, only for branch openwrt-18.06-k5.4
#-- sed -i 's/LICENSE/LICENSES/g' target/toolchain/Makefile

# Change default shell to zsh
#-- sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd
# Change default shell from /bin/ash to /bin/bash
sed -i 's/\/bin\/ash/\/bin\/bash/g' package/base-files/files/etc/passwd
# steven <-
