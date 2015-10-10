--- HrrGrrv2 ---

-- lets get our location -- 
local awful = require("awful")
local AWESOME_DIR = awful.util.getdir("config")

theme = {}

function theme.fg(color, text) 
	return '<span color="' .. color .. '">' .. text .. '</span>' end 

local na = awful.util.color_strip_alpha

function theme.init()
	theme.spacer.text= " "
	theme.leftcap.text = theme.fg(theme.grey, "[") 
	theme.midcap.text = theme.fg(theme.grey, "][")
	theme.rightcap.text = theme.fg(theme.grey, "]")
end

theme.font          = "terminus 8"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

-- todo figure out colors --
theme.grey = "#404040"
theme.bgrey = "#555753"
theme.red = "#CC0000"
theme.bred = "#EF2929"
theme.green = "#4E9A06"
theme.bgreen = "#8AE234"
theme.yellow = "#C4A000"
theme.byellow = "#FCE94F"
theme.blue = "#195089"
theme.bblue = "#729FCF"
theme.purple = "#75507B"
theme.bpurple = "#AD7FAB"
theme.cyan = "#16A8AA"
theme.bcyan = "#34E2E2"

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

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg " .. AWESOME_DIR .. "/huruk/кыся.jpg" }

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

theme.fg_widget_clock  = na(theme.border_focus)
theme.fg_widget_value  = na(theme.fg_normal)
theme.fg_widget_value_important  = "#E80F28"

return theme
