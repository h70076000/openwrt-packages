# Copyright (C) 2016 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bafa

LUCI_TITLE:=LuCI support for bafa
LUCI_DEPENDS:=

define Package/$(PKG_NAME)/conffiles
/etc/bafayun
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "${IPKG_INSTROOT}" ] || {
	( . /etc/uci-defaults/luci-bafa ) && rm -f /etc/uci-defaults/luci-bafa
	exit 0
}
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
