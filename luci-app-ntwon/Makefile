#
# Copyright (C) 2008-2014 The LuCI Team <luci@lists.subsignal.org>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=v2.04
PKG_RELEASE:=1

LUCI_TITLE:=LuCI support for ntwon
LUCI_DEPENDS:=+kmod-tun
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-ntwon

define Package/$(PKG_NAME)/prerm
#!/bin/sh
if [ -f /etc/config/ntwon ] ; then
  echo "备份ntwon配置文件/etc/config/ntwon到/tmp/ntwon_backup"
  echo "不重启设备之前再次安装luci-app-ntwon 配置不丢失,不用重新配置"
  mv -f /etc/config/ntwon /tmp/ntwon_backup
fi
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
chmod +x /etc/init.d/ntwon
if [ -f /tmp/ntwon_backup ] ; then
  echo "发现ntwon备份配置文件/tmp/ntwon_backup，开始恢复到/etc/config/ntwon"
  mv -f /tmp/ntwon_backup /etc/config/ntwon
  echo "请前往 服务 - NTWON组网 界面进行重启插件"
fi
endef
