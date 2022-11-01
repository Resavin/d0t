local awful = require "awful"
local cyclefocus = require('cyclefocus')
-- cyclefocus.display_notifications = false
local revelation=require("revelation")
revelation.init()
modkey = "Mod4"
alt = "Mod1"
local rmbflag = false

-- local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")
-- hotkeys_popup.hotkeys_bg = 
-- awful.hotkeys_popup.keys.tmux.add_rules_for_terminal({ rule = { name = "no window ever has a name like this" }})

awful.keyboard.append_global_keybindings({
    -- awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
    --           {description="show help", group="awesome"}),
    -- awful.key({ modkey,           }, "w", function () mainmenu:show() end,
    --           {description = "show main menu", group = "awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    -- awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              -- {description="show help", group="awesome"}),
    
    awful.key({ modkey, "Shift"   }, "c", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    -- awful.key({ modkey }, "x",
    --           function ()
    --               awful.prompt.run {
    --                 prompt       = "Run Lua code: ",
    --                 textbox      = awful.screen.focused().mypromptbox.widget,
    --                 exe_callback = awful.util.eval,
    --                 history_path = awful.util.get_cache_dir() .. "/history_eval"
    --               }
    --           end,
    --           {description = "lua execute prompt", group = "awesome"}),
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey },            "d",     function () awful.spawn.with_shell("rofi -i -show drun -modi drun -show-icons") end,
              {description = "Drun prompt", group = "launcher"}),
    -- awful.key({ modkey },            "r",     function () awful.spawn.with_shell("rofi -i -show run -modi run") end,
    -- awful.key({ modkey },            "r",     function () awful.spawn.with_shell("fish -c \"$(rofi -dmenu -p 'Run command')\"") end,
    awful.key({modkey}, "r",
        -- function() awful.util.spawn("alacritty --class run_menu") end),
        function() awful.util.spawn("xterm -c run_menu") end),
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    -- custom key
    awful.key({ modkey, "Control" }, "e", function() awful.spawn("pcmanfm") end,
              {description = "open pcman", group = "launcher"}),
    awful.key({ modkey, }, "e", function() awful.spawn("nautilus --new-window") end,
              {description = "open nautilus", group = "launcher"}),
    awful.key({ modkey, "Shift" },  "s",     function ()
        -- awful.util.spawn("flameshot gui") end,
        awful.util.spawn_with_shell("/home/mehrunes/customScripts/screen") end,
              {description = "screenshot selected area", group = "launcher"}),
    awful.key({ modkey, "Shift" },  "q",     function ()
      awful.util.spawn("/home/mehrunes/customScripts/offnutEcran.sh") end,
              {description = "offnutEcran", group = "scripts"}),
    awful.key({ modkey, "Shift" },  "a",     function ()
      awful.util.spawn("/home/mehrunes/customScripts/ip.lua") end,
      -- awful.spawn.easy_async_with_shell("curl -s eth0.me | dmenu") end,
              {description = "show ip", group = "scripts"}),
    awful.key({ modkey, "Shift" },  "x",     function ()
      -- awful.util.spawn("/home/mehrunes/customScripts/lock") end,
      awful.util.spawn_with_shell("i3lock-fancy -f Iosevka") end,
              {description = "lock screen", group = "scripts"}),


    -- awful.key({  },  "Print",     function ()
    --     awful.util.spawn("flameshot full -p /tmp") end,
    --           {description = "screenshot full area to /tmp", group = "launcher"}),
    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/Screenshots/ 2>/dev/null'", false) end),
    awful.key({ modkey, "Shift"}, 'e', function ()
        local matcher = function (c)
            return awful.rules.match(c, {class = 'Sublime_text'})
        end
        awful.client.run_or_raise('subl', matcher)
    end),
    awful.key({ modkey, "Shift"}, 'w', function ()
        local matcher = function (c)
            return awful.rules.match(c, {class = 'Emacs'})
        end
        awful.client.run_or_raise('emacsclient -c -a \'emacs\'', matcher)
    end),
    -- awful.key({modkey}, "g", function () awful.util.spawn("xdotool sleep 0.25 click 3") end),
    awful.key({modkey}, "g", function () 
        if rmbflag then
            root.fake_input('button_release', "3")
            rmbflag = false
        else
            root.fake_input('button_press', "3") 
            rmbflag = true
        end
    end),
    awful.key({ modkey, }, 'b', function ()
        local matcher = function (c)
            return awful.rules.match(c, {class = 'Chromium'})
        end
        awful.client.run_or_raise('chromium', matcher)
    end,
    {description = "chromium run or raise", group = "launcher"});

})



-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Down",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Up",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    -- modkey+Shift+Tab: backwards
    awful.key({ alt, }, "Tab", function(c)
        cyclefocus.cycle({modifier="Super_L"})
    end),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "Right",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "Left",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Какая-то фигня со стакаоверфлоу 
    -- awful.key({ modkey,           }, "Tab",
    -- function ()
    --     for c in awful.client.iterate(function (x) return true end) do
    --         client.focus = c
    --         client.focus:raise()
    --     end
    -- end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {description = "restore minimized", group = "client"}),

})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
  awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "w", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    -- awful.key({ alt    },  "Right",     function () awful.tag.incmwfact( 0.05)          end,
    --           {description = "increase master width factor", group = "layout"}),
    -- awful.key({ alt    }, "Left",     function () awful.tag.incmwfact(-0.05)          end,
    --           {description = "decrease master width factor", group = "layout"}),                     -- Убрал потому что тут другой бинд есть, а ещё такие бинды блочили хромиумовские бинды
    -- awful.key({ alt    },  "Up",     function () awful.client.incwfact( 0.05)          end,
    --           {description = "increase master width factor", group = "layout"}),
    -- awful.key({ alt    }, "Down",     function () awful.client.incwfact(-0.05)          end,
    --           {description = "decrease master width factor", group = "layout"}),                     -- Эти почему-то не работают
    -- awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              -- {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
})



-- Volume

awful.keyboard.append_global_keybindings({
	awful.key({ }, "XF86AudioRaiseVolume", function() awful.spawn.with_shell("pamixer -i 3") end),
	awful.key({ }, "XF86AudioLowerVolume", function() awful.spawn.with_shell("pamixer -d 3") end),
	awful.key({ }, "XF86AudioMute", function() awful.spawn.with_shell("pamixer -t") end),
    awful.key({ },  "XF86AudioMicMute",     function ()  
        awful.util.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
        awesome.emit_signal("signal::mic") end,
              {description = "mute mic", group = "laptop"}),
     awful.key({modkey}, "s", revelation)
})

-- Brightness

awful.keyboard.append_global_keybindings({
	awful.key({ }, "XF86MonBrightnessUp", function() awful.spawn.with_shell("brightnessctl set 3%+") end),
	awful.key({ }, "XF86MonBrightnessDown", function() awful.spawn.with_shell("brightnessctl set 3%-") end),
})


awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "x", function() awesome.emit_signal("ui::powermenu:open") end)
})


awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey,   }, "q",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),
        awful.key({ modkey,  }, "space",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),
        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, "Control" }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "client"}),
        awful.key({ modkey, "Shift"   }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "client"}),
        
        -- if awful.layout.get == awful.layout.suit.floating then НУжно наверное инпут обрабатывать, чтобы иф работал
            awful.key({ modkey, "Shift"  }, "Down",   function (c) c:relative_move( 20,  20, -40, -40) end,
                {description = "Decrease size in floating", group = "client"}),
            awful.key({ modkey, "Shift"  }, "Up",  function (c) c:relative_move(-20, -20,  40,  40) end,
                {description = "Increase size in floating", group = "client"}),
        -- end
    })
end)

local lain = require("lain")
local quake = lain.util.quake()
local flag = -1
awful.keyboard.append_global_keybindings({
        awful.key({ modkey, }, "n", 
            function () 
                for _, t in pairs(awful.screen.focused().tags) do
                    lain.util.useless_gaps_resize(flag*20, awful.screen.focused(), t) 
                end
                flag = flag * -1
            end,
            {description = "increase gap", group = "layout"}),
        awful.key({ modkey, "Control" }, "=", function () lain.util.useless_gaps_resize(20) end,
            {description = "increase gaps", group = "customise"}),
        awful.key({ modkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-20) end,         
            {description = "decrease gaps", group = "customise"}),
        awful.key({ modkey, "Control" }, "z", function () quake:toggle() end,         
            {description = "decrease gaps", group = "customise"}),

})

