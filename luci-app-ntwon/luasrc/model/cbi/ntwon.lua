-- NTWON VPN configuration page. Made by 981213

local fs = require "nixio.fs"

m = Map("ntwon", translate("NTWON 组网"))
m.description = translate("NTWON 组网 是一个简易称定的组网软件.")

-- Basic config
-- edge
m:section(SimpleSection).template = "ntwon/status"

s = m:section(TypedSection, "edge", translate("NTWON 组网设置"))
s.anonymous = true
s.addremove = true

switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false

tunname = s:option(Value, "tunname", translate("TUN 虚拟网卡名"))
tunname.optional = false

mode = s:option(ListValue, "mode", translate("Interface mode"))
mode:value("dhcp")
mode:value("static")

ipaddr = s:option(Value, "ipaddr", translate("Interface IP address"))
ipaddr.optional = false
ipaddr.datatype = "ip4addr"
ipaddr:depends("mode", "static")

prefix = s:option(Value, "prefix", translate("Interface netmask"))
prefix:value("8", "8 (255.0.0.0)")
prefix:value("16", "16 (255.255.0.0)")
prefix:value("24", "24 (255.255.255.0)")
prefix:value("28", "28 (255.255.255.240)")
prefix.optional = false
prefix.datatype = "range(0,32)"
prefix:depends("mode", "static")

mtu = s:option(Value, "mtu", translate("MTU"))
mtu.datatype = "range(1,1500)"
mtu.optional = false

supernode = s:option(Value, "supernode", translate("Supernode Host"))
supernode.optional = false
supernode.rmempty = false

port = s:option(Value, "port", translate("Supernode Port"))
port.optional = false
port.rmempty = false

community = s:option(Value, "community", translate("NTWON 组网识别码"))
community.optional = false
community.readonly="readonly"

route = s:option(Flag, "route", translate("Enable packet forwarding"))
route.rmempty = false

masquerade = s:option(Flag, "masquerade", translate("Enable IP masquerade"))
masquerade.description = translate("Make packets from LAN to other edge nodes appear to be sent from the tunnel IP. This can make setting up your firewall easier")
masquerade.orientation = "horizontal"
masquerade:depends("route", 1)
masquerade.rmempty = false

-- Static route
s = m:section(TypedSection, "route", translate("NTWON 路由设置"),
              translate("本地需加入对端路由和虚拟IP才能正常访问对端网段下的设备"))
s.anonymous = true
s.addremove = true
s.template = "cbi/tblsection"

---- enable
switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false

---- IP address
o = s:option(Value, "ip", translate("IP"))
o.optional = false
o.datatype = "ip4addr"
o.rmempty = false

---- IP mask
o = s:option(Value, "mask", translate("Mask"))
o:value("8", "8 (255.0.0.0)")
o:value("16", "16 (255.255.0.0)")
o:value("24", "24 (255.255.255.0)")
o:value("28", "28 (255.255.255.240)")
o.optional = false
o.datatype = "range(0,32)"
o.default = "24"

---- Gateway
o = s:option(Value, "gw", translate("Gateway"))
o.optional = false
o.datatype = "ip4addr"
o.rmempty = false

---- Description
o = s:option(Value, "desc", translate("Description"))
o.optional = false

return m
