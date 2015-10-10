-- menu --

local menu = {}
local root = {}
local launcher = {}

function menu.get_menu()
	local temp = {}

	temp = {
		{"Manual", terminal .. "-e man awesome"},
		{"Edit Config", editor_cmd .. " " .. awesome.conffile},
		{"Restart", awesome.restart},
		{"Quit", awesome.quit}
	}

	root = {
		{"awesome", temp, beautiful.awesome_icon},
		{"open terminal", terminal}
	}

	return root
end

return menu