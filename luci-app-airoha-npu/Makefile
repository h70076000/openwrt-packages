#
# Copyright (c) 2017-2019, The xterm.js authors (MIT License)
# Copyright (c) 2014-2017, SourceLair, Private Company (www.sourcelair.com) (MIT License)
# Copyright (c) 2012-2013, Christopher Jeffrey (MIT License)
#
# This is free software, licensed under the MIT License.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=1.0.1
PKG_RELEASE:=1
PKG_LICENSE:=Apache-2.0

LUCI_TITLE:=LuCI Airoha SoC Status (NPU, CPU, Frame Engine)
LUCI_DEPENDS:=+luci-base @TARGET_airoha

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
