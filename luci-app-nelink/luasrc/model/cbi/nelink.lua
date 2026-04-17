local m, s ,o
local fs = require "nixio.fs"

m = Map("nelink")
m.title = translate("NE组网")
m.description = translate('NE组网是一个异地夸网组网工具')
m:section(SimpleSection).template = "nelink/nelink_status"

s = m:section(TypedSection, "nelink", translate("基本配置"))
s.addremove = false
s.anonymous = true

o = s:option(Flag,"enabled",translate("启用"))
o.default = 0

o = s:option(Value, "host",translate("服务器地址"))
o.default= "bemfa.com"

o = s:option(Value, "port",translate("监听地址器端口"),translate("本机IP:端口"))
o.default= "192.168.1.1:23336"

o = s:option(Value, "ipaddr",translate("虚拟IP"))
o.placeholder = "10.26.3.x"

o = s:option(Value, "clientid",translate("账户私钥"),translate("必填项不能为空"))
o.password = true
o.readonly="readonly"

o = s:option(Value, "tunname", translate("虚拟网卡名"))
o.default= "nelink0"

-- Static route
s = m:section(TypedSection, "route", translate("加入异地路由"),
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

