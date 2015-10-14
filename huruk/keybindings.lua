--keybindings--

local vicious = require("vicious")
local keydoc = require("huruk.keydoc")

local keybindings = {}

function keybindings.get_global_keys()

    local globalkeys = awful.util.table.join(
        keydoc.group("Virtual desktops"),
        awful.key({ modkey,           }, "Left",   awful.tag.viewprev, "Switch to previous"         ),
        awful.key({ modkey,           }, "Right",  awful.tag.viewnext, "Switch to next"             ),
        awful.key({ modkey,           }, "Escape", awful.tag.history.restore, "Restore history"     ),

        keydoc.group("Focus"),
        awful.key({ modkey,           }, "j",
            function ()
                awful.client.focus.byidx(1)
                if client.focus then client.focus:raise() end
            end, "Focus next window"),
        awful.key({ modkey,           }, "k",
            function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
            end, "Focus previous window"),

        -- programs --
        keydoc.group("Programs"),
        awful.key({ modkey }, "w",          function () awful.util.spawn("google-chrome-stable") end, "Google Chrome"),
        awful.key({ modkey }, "p",          function () awful.util.spawn("pidgin") end, "Pidgin"),
        awful.key({ modkey,    }, "Return", function () awful.util.spawn(terminal) end, "Terminal"),

        -- volume keys --
        keydoc.group("Volume management"),
        awful.key({ modkey }, "#75",        function () awful.util.spawn("amixer -c 0 set Master 1+",false) vicious.force({ volume }) end, "Increase"),
        awful.key({ modkey }, "#74",        function () awful.util.spawn("amixer -c 0 set Master 1-",false) vicious.force({ volume }) end, "Decrease"),

        -- Layout manipulation
        keydoc.group("Layout manipulation"),
        awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end, "Swap forward"),
        awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end, "Swap backward"),
        awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end, "I have no idea"),
        awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, "I have no idea"),
        awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
        awful.key({ modkey,           }, "Tab",
            function ()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end, "Tab"),
        
        keydoc.group("Awesome control"),
        awful.key({ modkey, "Control" }, "r", awesome.restart, "Restart"),
        awful.key({ modkey, "Shift"   }, "q", awesome.quit, "Quit"      ),

        keydoc.group("Window manipulation"),
        awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end, "Increase master window width"),
        awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end, "Decrease master window width"),
        awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end, "Increase number of master windows"),
        awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end, "Decrease number of master windows"),
        awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end, "Increase number of column windows"),
        awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end, "Decrease number of column windows"),
        awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end, "Switch to next layout"),
        awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end, "Switch to previous layout"),

        awful.key({ modkey, "Control" }, "n", awful.client.restore, "Unminimize a random client"),

        -- Prompt
        keydoc.group("Prompts"),
        awful.key({ modkey },            "r",     function () promptbox[mouse.screen]:run() end, "Open run prompt"),

        awful.key({ modkey }, "x",
                  function ()
                      awful.prompt.run({ prompt = "Run Lua code: " },
                      promptbox[mouse.screen].widget,
                      awful.util.eval, nil,
                      awful.util.getdir("cache") .. "/history_eval")
                  end, "Open lua prompt"),
        awful.key({ modkey, }, "F1", keydoc.display)
    )

    return globalkeys
end

return keybindings