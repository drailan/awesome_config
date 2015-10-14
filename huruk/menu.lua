-- menu --

local menu = {}
local root = {}
local launcher = {}
local menu_theme = {}


function theme_load(theme)
   local cfg_path = awful.util.getdir("config")

   -- Create a symlink from the given theme to /home/user/.config/awesome/current_theme
   awful.util.spawn("ln -sfn " .. cfg_path .. "/huruk/themes/" .. theme .. " " .. cfg_path .. "/huruk/current_theme/theme.lua")
   awesome.restart()
end

function theme_menu()
   	-- List your theme files and feed the menu table
   	local cmd = "ls -1 " .. awful.util.getdir("config") .. "/huruk/themes/"
   	local f = io.popen(cmd)

	for l in f:lines() do
		local item = { l, function () theme_load(l) end }
		table.insert(menu_theme, item)
	end

   	f:close()
end

function menu.get_menu()
	local menu_awesome = {}
	theme_menu()

	menu_awesome = {
		{"Manual", terminal .. "-e man awesome"},
		{"Edit Config", editor_cmd .. " " .. awesome.conffile},
		{"Restart", awesome.restart},
		{"Quit", awesome.quit}
	}

	root = {
		{"awesome", menu_awesome, beautiful.awesome_icon},
		{ "themes", menu_theme },
		{"open terminal", terminal}
	}

	return root
end

return menu