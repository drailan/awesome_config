-- entry point --
-- we will fall back to /etc/xdg/awesome/rc.lua if something goes wrong

local awful = require("awful")
local naughty = require("naughty")

--dofile("/etc/xdg/awesome/rc.lua")

local CONFIG_DIR = awful.util.getdir("config")
local rc, err = loadfile(CONFIG_DIR .. "/aw.lua")

if rc then 
	rc, err = pcall(rc)
	if rc then
		return
	end
end

-- fallback --
dofile("/etc/xdg/awesome/rc.lua")

for s = 1, screen.count() do
	mypromptbox[s].text = awful.util.escape(err:match("[^\n]*"))
end

naughty.notify({
	text = "AwesomeWM crashed during startup on " .. os.date("%d%/%m/%Y %T:\n\n") .. err, 
	timeout = 0
})
