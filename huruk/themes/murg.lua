--- HrrGrrv2 4 Murg ---

-- lets get our location -- 
local awful = require("awful")
local AWESOME_DIR = awful.util.getdir("config")

theme = {}

function theme.fg(t) 
	local weight = t.weight or "normal"
	local color = assert(t.color)
	local text = assert(t.text)
	local font = t.font or theme.font

	return '<span weight="' .. weight .. '" color="' .. color .. '">' .. text .. '</span>' 		
end

local na = awful.util.color_strip_alpha

function theme.init()
	theme.spacer.text= " "
	theme.leftcap.text = theme.fg({ color = theme.leftcap_c, text = "[" }) 
	theme.midcap.text = theme.fg({ color = theme.midcap_c, text = "][" })
	theme.rightcap.text = theme.fg({ color = theme.rightcap_c, text = "]" })
end

-- 0JzRg9GA0LMsIA==8178474d046cf2f0acf23f67ca963f24e116b0d91d3dde17b602688177efe5a849255d89fb782d91b4e824104a7a5d33c182ba062ffcb73317f8bec4e9460460 -- 
theme.wallpaper_cmd = { "awsetbg " .. AWESOME_DIR .. "/huruk/кыся.jpg" }

theme.font          = "terminus 8"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#001900"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#000000"

theme.fg_normal     = "#4E9A06"
theme.fg_focus      = "#4E9A06"
theme.fg_urgent     = "#001900"
theme.fg_minimize   = "#4E9A06"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

theme.taglist_squares_sel = AWESOME_DIR .. "/huruk/taglist/squarefw.png"
theme.taglist_squares_unsel = AWESOME_DIR .. "/huruk/taglist/squarefw.png"

theme.tasklist_floating_icon = AWESOME_DIR .. "/huruk/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = AWESOME_DIR .. "/huruk/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- Define the image to load
theme.titlebar_close_button_normal = AWESOME_DIR .. "/huruk/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = AWESOME_DIR .. "/huruk/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = AWESOME_DIR .. "/huruk/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = AWESOME_DIR .. "/huruk/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = AWESOME_DIR .. "/huruk/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = AWESOME_DIR .. "/huruk/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = AWESOME_DIR .. "/huruk/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = AWESOME_DIR .. "/huruk/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = AWESOME_DIR .. "/huruk/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = AWESOME_DIR .. "/huruk/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = AWESOME_DIR .. "/huruk/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = AWESOME_DIR .. "/huruk/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = AWESOME_DIR .. "/huruk/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = AWESOME_DIR .. "/huruk/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = AWESOME_DIR .. "/huruk/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = AWESOME_DIR .. "/huruk/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = AWESOME_DIR .. "/huruk/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = AWESOME_DIR .. "/huruk/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = AWESOME_DIR .. "/huruk/layouts/fairhw.png"
theme.layout_fairv = AWESOME_DIR .. "/huruk/layouts/fairvw.png"
theme.layout_floating  = AWESOME_DIR .. "/huruk/layouts/floatingw.png"
theme.layout_magnifier = AWESOME_DIR .. "/huruk/layouts/magnifierw.png"
theme.layout_max = AWESOME_DIR .. "/huruk/layouts/maxw.png"
theme.layout_fullscreen = AWESOME_DIR .. "/huruk/layouts/fullscreenw.png"
theme.layout_tilebottom = AWESOME_DIR .. "/huruk/layouts/tilebottomw.png"
theme.layout_tileleft   = AWESOME_DIR .. "/huruk/layouts/tileleftw.png"
theme.layout_tile = AWESOME_DIR .. "/huruk/layouts/tilew.png"
theme.layout_tiletop = AWESOME_DIR .. "/huruk/layouts/tiletopw.png"
theme.layout_spiral  = AWESOME_DIR .. "/huruk/layouts/spiralw.png"
theme.layout_dwindle = AWESOME_DIR .. "/huruk/layouts/dwindlew.png"

theme.spacer = widget({ type = "textbox"})
theme.leftcap = widget({ type = "textbox"})
theme.midcap = widget({ type = "textbox"})
theme.rightcap = widget({ type = "textbox"})

-- COLORS --

-- help --
theme.help_grp = "#4E9A06" -- green
theme.help_key = "#4DBD33" -- grass
theme.help_msg = "#aaaaaa" -- light-grey

-- separators --
theme.leftcap_c = "#4E9A06" -- green
theme.midcap_c =  "#4E9A06" -- green
theme.rightcap_c = "#4E9A06" -- green

-- widgets

-- memory --
theme.memory = "#4E9A06" -- green

-- cpu -- 
theme.cpu_spacer = "#404040"
theme.cpu_low = "#4E9A06" -- green
theme.cpu_med = "#C4A000" -- yellow
theme.cpu_high = "#CC0000" -- red
theme.cpu_wtf = "#EF2929" -- bright red

-- wifi -- 
theme.wifi_off = "#EF2929" -- bright red
theme.wifi_low = "#CC0000" -- red
theme.wifi_mid = "#C4A000" -- yellow
theme.wifi_hi = "#4E9A06" -- green

-- mpd --
theme.mpd_paused = "#4DBD33" -- green
theme.mpd_stopped = "#4DBD33" -- green
theme.mpd_playing = "#4DBD33" -- green

-- hostname --
theme.hostname_host = "#4E9A06" -- green
theme.hostname_at = "#16A8AA" -- cyan
theme.hostname_hostname = "#16A8AA" -- cyan

-- volume -- 
theme.volume_low = "#CC0000" -- red
theme.volume_mid = "#C4A000" -- yellow
theme.volume_hi = "#4E9A06" -- green
theme.volume_wtf = "#CC0000" -- red

-- battery --
theme.battery_high = "#4E9A06" -- green
theme.battery_mid = "#C4A000" -- yellow
theme.battery_lo = "#CC0000" -- red
theme.battery_crit = "#EF2929" -- bright red


return theme
