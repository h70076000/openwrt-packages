module("luci.controller.nelink", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/nelink") then
		return
	end

	local e=entry({"admin",  "services", "nelink"}, alias("admin", "services", "nelink", "setting"),_("ne联网"), 46)
	e.dependent=false
	e.acl_depends={ "luci-app-nelink" }
	entry({"admin", "services", "nelink", "setting"}, cbi("nelink"), _("配置"), 47).leaf=true
	entry({"admin", "services", "nelink", "nelink_status"}, call("act_status"))
	entry({"admin", "services", "nelink", "nelink_log"}, form("nelink_log"), _("日志"), 48).leaf = true
	entry({"admin", "services", "nelink", "get_log"}, call("get_log"), nil).leaf = true
	entry({"admin", "services", "nelink", "clear_log"}, call("clear_log")).leaf = true
end

function act_status()
	local sys  = require "luci.sys"
	local e = { }
	e.running = sys.call("pidof netlink >/dev/null") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
function get_log()
    local log = ""
    local files = {"/var/log/nelink.log"}
    for i, file in ipairs(files) do
        if luci.sys.call("[ -f '" .. file .. "' ]") == 0 then
            log = log .. luci.sys.exec("cat " .. file)
        end
    end
    luci.http.write(log)
end

function clear_log()
	luci.sys.call("echo '' >/var/log/nelink.log")
end
