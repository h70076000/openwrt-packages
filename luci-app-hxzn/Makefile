#
# Copyright (C) 2008-2014 The LuCI Team <luci@lists.subsignal.org>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=1.2.16
PKG_RELEASE:=1

LUCI_TITLE:=LuCI support for hxzn
LUCI_DEPENDS:=+kmod-tun
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-hxzn

define Package/$(PKG_NAME)/prerm
#!/bin/sh
if [ -f /etc/config/hxzn ] ; then
  echo "备份hxzn配置文件/etc/config/hxzn到/tmp/hxzn_backup"
  echo "不重启设备之前再次安装luci-app-hxzn 配置不丢失,不用重新配置"
  mv -f /etc/config/hxzn /tmp/hxzn_backup
fi
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
chmod +x /etc/init.d/hxzn
if [ -f /tmp/hxzn_backup ] ; then
  echo "发现hxzn备份配置文件/tmp/hxzn_backup，开始恢复到/etc/config/hxzn"
  mv -f /tmp/hxzn_backup /etc/config/hxzn
  echo "请前往 服务 - 宏兴智能组网 界面进行重启插件"
fi
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
