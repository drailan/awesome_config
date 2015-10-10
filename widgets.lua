-- widgets --
local vicious = require("vicious")
local beautiful = require("beautiful")

local widgets = {}

-- your variables here -- 
local WIFI_ADAPTER_NAME = "wlp6s0"
local BATTERY_NAME 		= "BAT1"

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
	vicious.register(memwidget, vicious.widgets.mem, "$1% ($2MB/$3MB)", 13)

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
		  cores = 8 --set # of cores/cpus
		  for i = 1,cores do
		    if args[i+1] >= 0 and args[i+1] < 10 then
		      coreuse = theme.fg(theme.green, "0" .. args[i+1])   
		    elseif  args[i+1] >= 40 and args[i+1] < 80 then
		      coreuse = theme.fg(theme.yellow, args[i+1])
		    elseif args[i+1] >= 80 and args[i+1] < 100 then
		      coreuse = theme.fg(theme.red, args[i+1]) 
		    elseif args[i+1] >= 100 then
		      coreuse = theme.fg(theme.bred, "**") 
		    else
		      coreuse = theme.fg(theme.green, args[i+1])
		    end
		    
		    if i < cores then 
		    	cpuuse = cpuuse .. coreuse .. theme.fg(theme.grey, "•")
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
	local wifiicon = widget({type = "imagebox" })
	wifiicon.image = image(beautiful.widget_wifi_hi)
	
	local wifiwidget = widget({ type = "textbox" }) --display SSID and rate
	vicious.register(wifiwidget, vicious.widgets.wifi,
     function (widget, args)
      if args["{link}"] == 0 then
        wifiicon.image = image(beautiful.widget_wifi_off)
        return theme.fg(theme.bred, "∅")
      elseif args["{rate}"] <= 11 then
        wifiicon.image = image(beautiful.widget_wifi_lo)
        return string.format("%s " .. theme.fg(theme.red, "(%i mbps)"), args["{ssid}"], args["{rate}"])
      elseif args["{rate}"] > 11 and args["{rate}"] < 54 then
        wifiicon.image = image(beautiful.widget_wifi_mid)
        return string.format("%s " .. theme.fg(theme.yellow, "(%i mbps)"), args["{ssid}"], args["{rate}"])
      else
        wifiicon.image = image(beautiful.widget_wifi_hi)
        return string.format("%s " .. theme.fg(theme.green, "(%i mbps)"), args["{ssid}"], args["{rate}"])
      end
     end, 11, WIFI_ADAPTER_NAME)

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
	        	return args["{Artist}"] ..' - '.. args["{Title}"]
	  		elseif args["{state}"] == "Pause" then
	    		mpdicon.image = image(beautiful.widget_pause)
	    		return args["{Artist}"] ..' - '.. args["{Title}"]
	  		else
			    mpdicon.image = image(beautiful.widget_play)
	    		return args["{Artist}"] ..' - '.. args["{Title}"]
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
	vicious.register(hostnamewidget, vicious.widgets.os, theme.fg(theme.green, "$3") .. theme.fg(theme.cyan, "@$4"), 3600)

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
	    return theme.fg(theme.yellow, args[1])
	  elseif args[1] >= 66 then
	    volicon.image = image(beautiful.widget_vol_hi)
	    return theme.fg(theme.green, args[1])
	  elseif args[1] == 0 then
	    volicon.image = image(beautiful.widget_vol_mute)
	    return theme.fg(theme.red, args[1])
	  else
	    volicon.image = image(beautiful.widget_vol_lo)
	    return theme.fg(theme.red, args[1])
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

function widgets.battery() 
	local baticon = widget({ type = "imagebox" })
	baticon.image = image(beautiful.widget_bat_hi)
	local batchrg = widget({ type = "imagebox" })
	batchrg.image = image(beautiful.widget_bat_full)
	local batterywidget = widget({ type = "textbox" }) --display battery state and charge
	vicious.register(batterywidget, vicious.widgets.bat,
	  function (widget, args)
	    if args[2] >= 30 and args [2] < 75 then
	      baticon.image = image(beautiful.widget_bat_mid)
	      return theme.fg(theme.yellow, args[2] .. "%")
	    elseif args[2] >= 10 and args[2] < 30 then
	      baticon.image = image(beautiful.widget_bat_lo)
	      return theme.fg(theme.red, args[2] .. "%")
	    elseif args[2] >= 6 and args[2] < 10 then
	      baticon.image = image(beautiful.widget_bat_lo)
	      return theme.fg(theme.red, args[2] .. "%")
	    elseif args[2] < 6 then
	      baticon.image = image(beautiful.widget_bat_crit)
	    else
	      baticon.image = image(beautiful.widget_bat_hi)
	      return theme.fg(theme.green, args[2] .. "%")
	    end

	  end, 61, BATTERY_NAME)

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
