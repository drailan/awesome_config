-- HrrGrr v2 --

local awful       = require("awful")
local autofocus   = require("awful.autofocus")
local rules       = require("awful.rules")

local beautiful   = require("beautiful")
local naughty     = require("naughty")
local vicious     = require("vicious")

local keybindings = require("keybindings")
local menu        = require("menu")
local tasklist    = require("tasklist")
local widgets     = require("widgets")

-- home --
local CONFIG_DIR = awful.util.getdir("config");

-- theme init --
beautiful.init(CONFIG_DIR .. "/huruk/theme.lua")
theme.init()

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "subl3"
editor_cmd = terminal .. " -e " .. editor

-- modkey --
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- tags -- 
-- pick your layouts for each screen -- 
tags = {
  -- names  = { "α", "β", "γ", "δ", "ε" }, 
  names  = { "α", "ня", "γ", "δ", "ε" }, 
  layout = { layouts[2], layouts[2], layouts[2], layouts[2], layouts[2] }
}

for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- Launcher and Main menu
mymenu = awful.menu({items = menu.get_menu()})
mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymenu })

clientbox = {}
statusbox= {}
promptbox = {}
layoutbox = {}
taglist = {}
taglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
tasklist = {}
tasklist.buttons = 
  awful.util.table.join(
    awful.button({ }, 1, function (c)
                            if not c:isvisible() then
                                awful.tag.viewonly(c:tags()[1])
                            end
                            client.focus = c
                            c:raise()
                        end),
    awful.button({ }, 3, function ()
                            if instance then
                                instance:hide()
                                instance = nil
                            else
                                instance = awful.menu.clients({ width=250 })
                            end
                        end),
    awful.button({ }, 4, function ()
                            awful.client.focus.byidx(1)
                            if client.focus then client.focus:raise() end
                        end),
    awful.button({ }, 5, function ()
                            awful.client.focus.byidx(-1)
                            if client.focus then client.focus:raise() end
                        end)
)

for s = 1, screen.count() do
    promptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    layoutbox[s] = awful.widget.layoutbox(s)
    layoutbox[s]:buttons(awful.util.table.join(
                         awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                         awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                         awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                         awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, taglist.buttons)
    tasklist[s] = awful.widget.tasklist(function(c)
                                            return awful.widget.tasklist.label.currenttags(c, s)
                                        end, tasklist.buttons)

    clientbox[s] = awful.wibox({ position = "top", height = "16", screen = s })
    clientbox[s].widgets = {
        {
            taglist[s],
            promptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        layoutbox[s],
        theme.rightcap,
        widgets.clock(),
        theme.midcap,
        widgets.battery(),
        theme.midcap,
        widgets.volume(),
        theme.leftcap,

        s == 1 and widgets.systray() or nil,
        tasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }

    statusbox[s] = awful.wibox({ position = "bottom", height = "16", screen = s })
    statusbox[s].widgets = {
        { 
            theme.leftcap,
            widgets.cpu(),
            theme.midcap,
            widgets.memory(),
            theme.midcap,
            widgets.wifi(),
            theme.midcap,
            widgets.mpd(),
            theme.rightcap,
            layout = awful.widget.layout.horizontal.leftright
        },
        theme.rightcap,
        widgets.hostname(),
        theme.leftcap,
        layout = awful.widget.layout.horizontal.rightleft
    }
end

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev) 
))

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = true               end),
    awful.key({ modkey,           }, "m",      function (c)
                                                          c.maximized_horizontal = not c.maximized_horizontal
                                                          c.maximized_vertical   = not c.maximized_vertical
                                                      end)
)

keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

root.keys(keybindings.get_global_keys())

awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" }, properties = { floating = true } }
}

client.add_signal("manage", function (c, startup)
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
