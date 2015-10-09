-- widgets --
local vicious = require("vicious")
local beautiful = require("beautiful")

local widgets = {}

-- todo change your adapter name -- 
local WIFI_ADAPTER_NAME = "wlp6s0"

grey = "#404040"
bgrey = "#555753"
red = "#CC0000"
bred = "#EF2929"
green = "#4E9A06"
bgreen = "#8AE234"
yellow = "#C4A000"
byellow = "#FCE94F"
blue = "#195089"
bblue = "#729FCF"
purple = "#75507B"
bpurple = "#AD7FAB"
cyan = "#16A8AA"
bcyan = "#34E2E2"

-- helpers --
local spacer = widget({ type = "textbox"})
local leftcap = widget({ type = "textbox"})
local midcap = widget({ type = "textbox"})
local rightcap = widget({ type = "textbox"})

local function fg(color, text) return '<span color="' .. color .. '">' .. text .. '</span>' end 

function widgets.init()
	spacer.text= " "
	leftcap.text = fg(grey, "[") 
	midcap.text = fg(grey, "][")
	rightcap.text = fg(grey, "]")
end

-- widget types --
local clock = {}
local memory = {}
local systray = {}
local cpu = {}
local wifi = {}
local mpd = {}
local hostmame = {}
local volume = {}
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
		spacer,
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
		      coreuse = fg(green, "0" .. args[i+1])   
		    elseif  args[i+1] >= 40 and args[i+1] < 80 then
		      coreuse = fg(yellow, args[i+1])
		    elseif args[i+1] >= 80 and args[i+1] < 100 then
		      coreuse = fg(red, args[i+1]) 
		    elseif args[i+1] >= 100 then
		      coreuse = fg(bred, "**") 
		    else
		      coreuse = fg(green, args[i+1])
		    end
		    
		    if i < cores then 
		    	cpuuse = cpuuse .. coreuse .. fg(grey, "•")
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
		spacer,
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
        return fg(bred, "∅")
      elseif args["{rate}"] <= 11 then
        wifiicon.image = image(beautiful.widget_wifi_lo)
        return string.format("%s " .. fg(red, "(%i mbps)"), args["{ssid}"], args["{rate}"])
      elseif args["{rate}"] > 11 and args["{rate}"] < 54 then
        wifiicon.image = image(beautiful.widget_wifi_mid)
        return string.format("%s " .. fg(yellow, "(%i mbps)"), args["{ssid}"], args["{rate}"])
      else
        wifiicon.image = image(beautiful.widget_wifi_hi)
        return string.format("%s " .. fg(green, "(%i mbps)"), args["{ssid}"], args["{rate}"])
      end
     end, 11, WIFI_ADAPTER_NAME)

	wifi = {
		wifiicon,
		spacer,
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
		spacer,
		mpdwidget
	}

	return mpd
end

function widgets.hostname()
	local hosticon = widget({ type = "imagebox" })
	hosticon.image = image(beautiful.widget_host)
	local hostnamewidget = widget({ type = "textbox" }) --display username@hostname
	vicious.register(hostnamewidget, vicious.widgets.os, fg(green, "$3") .. fg(cyan, "@$4"), 3600)

	hostname = {
		hosticon,
		spacer,
		hostnamewidget,
		layout = awful.widget.layout.horizontal.rightleft
	}

	return hostname
end

return widgets
