-- NTWON Luci configuration page. Made by 981213

module("luci.controller.ntwon", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ntwon") then
		return
	end

	entry({"admin", "services"}, firstchild(), "智能服务", 45).dependent = false

	local page = entry({"admin", "services", "ntwon"}, cbi("ntwon"), _("NTWON组网"), 45)
	page.dependent = true
	page.acl_depends = { "luci-app-ntwon" }
	entry({"admin", "services", "ntwon", "setting"}, cbi("ntwon"), _("配置"), 47).leaf=true
	entry({"admin", "services", "ntwon", "ntwon_status"}, call("act_status"))
	entry({"admin", "services", "ntwon", "ntwon_log"}, form("ntwon_log"), _("日志"), 48).leaf = true
	entry({"admin", "services", "ntwon", "get_log"}, call("get_log"), nil).leaf = true
	entry({"admin", "services", "ntwon", "clear_log"}, call("clear_log")).leaf = true
end

function act_status()
	local sys  = require "luci.sys"
	local e = { }
	e.running = sys.call("pidof n2n-edge >/dev/null") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
function get_log()
    local log = ""
    local files = {"/var/log/ntwon.log"}
    for i, file in ipairs(files) do
        if luci.sys.call("[ -f '" .. file .. "' ]") == 0 then
            log = log .. luci.sys.exec("cat " .. file)
        end
    end
    luci.http.write(log)
end

function clear_log()
	luci.sys.call("echo '' >/var/log/ntwon.log")
end
