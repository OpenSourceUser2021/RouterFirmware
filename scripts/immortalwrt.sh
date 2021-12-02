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
git clone https://github.com/jerrykuku/go-aliyundrive-webdav.git package/go-aliyundrive-webdav
git clone https://github.com/jerrykuku/luci-app-go-aliyundrive-webdav.git package/luci-app-go-aliyundrive-webdav

#koolproxy
git clone https://github.com/iwrt/luci-app-ikoolproxy.git package/luci-app-ikoolproxy

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# Rename hostname to OpenWrt
pushd package/base-files/files/bin
sed -i 's/ImmortalWrt/OpenWrt/g' config_generate
popd

# Fix SDK
sed -i '/$(SDK_BUILD_DIR)\/$(STAGING_SUBDIR_HOST)\/usr\/bin/d' target/sdk/Makefile

# steven ->
# Fix Toolchain, only for branch openwrt-18.06-k5.4
#-- sed -i 's/LICENSE/LICENSES/g' target/toolchain/Makefile

# Change default shell to zsh
#-- sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd
# Change default shell from /bin/ash to /bin/bash
sed -i 's/\/bin\/ash/\/bin\/bash/g' package/base-files/files/etc/passwd
# steven <-
