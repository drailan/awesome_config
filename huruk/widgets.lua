-- widgets --
local vicious = require("vicious")
local beautiful = require("beautiful")
local awful = require("awful")

local io = { open = io.open }

local widgets = {}

-- widget types --
local clock = {}
local memory = {}
local systray = {}
local cpu = {}
local wifi = {}
local mpd = {}
local hostmame = {}
local volume = {}
local battery = {}
-------------------

local function get_adapter()
	local f = io.open("/proc/net/wireless")
	local target
	local contents = {}

	for line in f:lines() do
		table.insert(contents,line)
	end

	target = contents[3]
	if (string.match(target, "^%w+")) then
		name = string.match(target, "^%w+")
	end

	return name
end

-- widget creation functions --

function widgets.clock()
	clock = {
		align = "right"
	}
	return awful.widget.textclock(clock)
end

function widgets.systray()
	systray = {
		type = "systray"
	}
	return widget(systray)
end

function widgets.memory()
	local memicon = widget({ type = "imagebox" })
	memicon.image = image(beautiful.widget_mem_lo)

	local memwidget = widget({ type = "textbox" })
	vicious.register(memwidget, vicious.widgets.mem, theme.fg({ color = theme.memory, text = "$1% ($2MB/$3MB)"}), 13)

	memory = {
		memicon,
		theme.spacer,
		memwidget,
	}

	return memory
end

function widgets.cpu()
	local cpuicon = widget({type = "imagebox" })
	cpuicon.image = image(beautiful.widget_cpu_lo)
	
	local cpuwidget = widget({ type = "textbox" })
	vicious.register(cpuwidget, vicious.widgets.cpu,
		function (widget, args)
			cpuuse = "" 
			cores = tonumber(awful.util.pread("cat /proc/cpuinfo  | egrep -i processor | wc -l"))
			for i = 1,cores do
				if args[i+1] >= 0 and args[i+1] < 10 then
					if theme.fg then
						coreuse = theme.fg({ color = theme.cpu_low, text = "0" .. args[i+1] })
					else
						coreuse = "0" .. args[i+1]
					end
				elseif  args[i+1] >= 40 and args[i+1] < 80 then
					if theme.fg then
						coreuse = theme.fg({ color=theme.cpu_med, text=args[i+1] })
					else
						coreuse = args[i+1]
					end
				elseif args[i+1] >= 80 and args[i+1] < 100 then
					if theme.fg then
						coreuse = theme.fg({ color = theme.cpu_high, text = args[i+1] }) 
					else
						coreuse = args[i+1]
					end
				elseif args[i+1] >= 100 then
					if theme.fg then
						coreuse = theme.fg({ color = theme.wtf, text =  "**" }) 
					else
						coreuse = "**"
					end
				else
					if theme.fg then
						coreuse = theme.fg({ color = theme.cpu_low, text = args[i+1]})
					else
						coreuse = args[i+1]
					end
				end
			
				if i < cores then
					if theme.fg then
						cpuuse = cpuuse .. coreuse .. theme.fg({ color = theme.cpu_spacer, text = "•" })
					else
						cpuuse = cpuuse .. coreuse .. "•"
					end
				else 
					cpuuse = cpuuse .. coreuse
				end
			end
		  
			if args[1] >= 40 and args[1] < 80 then
				cpuicon.image = image(beautiful.widget_cpu_mid)
			elseif args[1] >= 80 then
				cpuicon.image = image(beautiful.widget_cpu_hi)
			else
				cpuicon.image = image(beautiful.widget_cpu_lo)
			end

			return cpuuse
		end, 1 )

	cpu = {
		cpuicon,
		theme.spacer,
		cpuwidget
	}	

	return cpu
end

function widgets.wifi() 
	local adapter = get_adapter()

	local wifiicon = widget({type = "imagebox" })
	wifiicon.image = image(beautiful.widget_wifi_hi)
	
	local wifiwidget = widget({ type = "textbox" }) 

	vicious.register(wifiwidget, vicious.widgets.wifi,
		function (widget, args)
			if args["{link}"] == 0 then
				wifiicon.image = image(beautiful.widget_wifi_off)
				return theme.fg({ color = theme.wifi_off, text = "∅" })
			elseif args["{rate}"] <= 11 then
				wifiicon.image = image(beautiful.widget_wifi_lo)
				return string.format(theme.fg({ color = theme.wifi_low, text = "%s " }) .. theme.fg({ color = theme.wifi_low, text = "(%i mbps)" }), args["{ssid}"], args["{rate}"])
			elseif args["{rate}"] > 11 and args["{rate}"] < 54 then
				wifiicon.image = image(beautiful.widget_wifi_mid)
				return string.format(theme.fg({ color = theme.wifi_mid, text = "%s " }) .. theme.fg({ color = theme.wifi_mid, text = "(%i mbps)" }), args["{ssid}"], args["{rate}"])
			else
				wifiicon.image = image(beautiful.widget_wifi_hi)
				return string.format(theme.fg({ color = theme.wifi_hi, text = "%s " }) .. theme.fg({ color = theme.wifi_hi, text = "(%i mbps)" }), args["{ssid}"], args["{rate}"])
			end
		 end, 11, adapter)

	wifi = {
		wifiicon,
		theme.spacer,
		wifiwidget
	}

	return wifi
end

function widgets.mpd()
	local mpdicon = widget({ type = "imagebox" })
	local mpdwidget = widget({ type = "textbox" })
	vicious.register(mpdwidget, vicious.widgets.mpd,
		function (widget, args)
			if args["{state}"] == "Stop" then 
				mpdicon.image = image(beautiful.widget_stop)
				return theme.fg({ text = args["{Artist}"] ..' - '.. args["{Title}"], color = theme.mpd_stopped })
			elseif args["{state}"] == "Pause" then
				mpdicon.image = image(beautiful.widget_pause)
				return theme.fg({ text = args["{Artist}"] ..' - '.. args["{Title}"], color = theme.mpd_paused })
			else
				mpdicon.image = image(beautiful.widget_play)
				return theme.fg({ text = args["{Artist}"] ..' - '.. args["{Title}"], color = theme.mpd_playing })
			end
		end, 3)

	mpd = {
		mpdicon,
		theme.spacer,
		mpdwidget
	}

	return mpd
end

function widgets.hostname()
	local hosticon = widget({ type = "imagebox" })
	hosticon.image = image(beautiful.widget_host)
	local hostnamewidget = widget({ type = "textbox" }) --display username@hostname
	vicious.register(
		hostnamewidget, 
		vicious.widgets.os, 
		theme.fg({ color = theme.hostname_host, text =  "$3" }) .. theme.fg({ color = theme.hostname_at, text = "@" }) .. theme.fg({ color = theme.hostname_hostname, text = "$4" }), 3600)

	hostname = {
		hosticon,
		theme.spacer,
		hostnamewidget,
		layout = awful.widget.layout.horizontal.rightleft
	}

	return hostname
end

function widgets.volume()
	local volicon = widget({ type = "imagebox" })
	volicon.image = image(beautiful.widget_vol_hi)
	local volumewidget = widget({ type = "textbox" }) --display volume
	vicious.register(volumewidget, vicious.widgets.volume, 
		function (widget, args)
			if args[1] >= 37 and args[1] < 66 then
				volicon.image = image(beautiful.widget_vol_mid)
				return theme.fg({ color = theme.volume_mid, text = args[1] })
			elseif args[1] >= 66 then
				volicon.image = image(beautiful.widget_vol_hi)
				return theme.fg({ color = theme.volume_hi, text = args[1] })
			elseif args[1] == 0 then
				volicon.image = image(beautiful.widget_vol_mute)
				return theme.fg({ color = theme.volume_low, text = args[1] })
			else
				volicon.image = image(beautiful.widget_vol_lo)
				return theme.fg({ color = theme.volume_wtf, text = args[1] })
			end
		end, 5, "Master")

	volume = {
		volumewidget,
		theme.spacer,
		volicon,
		layout = awful.widget.layout.horizontal.rightleft
	}

	return volume
end

function widgets.battery(bat) 
	local baticon = widget({ type = "imagebox" })
	baticon.image = image(beautiful.widget_bat_hi)
	local batchrg = widget({ type = "imagebox" })
	batchrg.image = image(beautiful.widget_bat_full)
	local batterywidget = widget({ type = "textbox" }) --display battery state and charge
	vicious.register(batterywidget, vicious.widgets.bat,
		function (widget, args)
			if args[2] >= 30 and args [2] < 75 then
				baticon.image = image(beautiful.widget_bat_mid)
				return theme.fg({ color = theme.battery_mid, text = args[2] .. "%" })
			elseif args[2] >= 10 and args[2] < 30 then
				baticon.image = image(beautiful.widget_bat_lo)
				return theme.fg({ color = theme.battery_lo, text = args[2] .. "%" })
			elseif args[2] >= 6 and args[2] < 10 then
				baticon.image = image(beautiful.widget_bat_lo)
				return theme.fg({ color = theme.battery_crit, text = args[2] .. "%" })
			elseif args[2] < 6 then
				baticon.image = image(beautiful.widget_bat_crit)
			else
				baticon.image = image(beautiful.widget_bat_hi)
				return theme.fg({ color = theme.battery_high, text = args[2] .. "%" })
			end
		end, 61, bat)

	battery = {
		batterywidget,
		theme.spacer,
		batchrg,
		baticon,
		layout = awful.widget.layout.horizontal.rightleft
	}

	return battery
end

return widgets
