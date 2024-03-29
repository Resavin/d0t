-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}
-- title
-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")
-- beautiful.init("~/.config/awesome/themes/default/theme.lua")


-- This is used later as the default terminal and editor to run.title
terminal = "alacritty"
editor = os.getenv("nvim") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.floating,
        --awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        --awful.layout.suit.tile.top,
        awful.layout.suit.fair,
        --awful.layout.suit.fair.horizontal,
        awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        --awful.layout.suit.magnifier,
        --awful.layout.suit.corner.nw,
    })
end)
-- }}}

-- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = beautiful.wallpaper,
                upscale   = true,
                downscale = true,
                widget    = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)
-- }}}

-- {{{ Wibar

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        widget   = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                mylauncher,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                mykeyboardlayout,
                wibox.widget.systray(),
                mytextclock,
                s.mylayoutbox,
            },
        }
    }
end)
-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    --           {description = "show main menu", group = "awesome"}),
    awful.key({ modkey, "Control" }, "c", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    -- awful.key({ modkey, "Shift"   }, "q", awesome.quit,
    --           {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    awful.key({ modkey }, "p", function() menubar.show() end,
          {description = "show the menubar", group = "launcher"}),    
    awful.key({ modkey },            "w",     function ()    
        awful.util.spawn("rofi -show window") end,
              {description = "window rofi", group = "launcher"}),


    awful.key({ modkey },            "d",     function ()    
        awful.util.spawn("rofi -show run") end,
              {description = "run rofi", group = "launcher"}),

    awful.key({ modkey },            "r",     function ()    
        awful.util.spawn("nwggrid -p -o 1") end,
              {description = "run nwggrid", group = "launcher"}),

    awful.key({ modkey,           }, "Return", function () 
        awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    
    awful.key({ modkey },            "e",     function ()    
        awful.util.spawn("nautilus") end,
              {description = "run nautilus", group = "launcher"}),

    awful.key({ modkey },            "a",     function ()
        awful.util.spawn("subl") end,
              {description = "run text", group = "launcher"}),

    awful.key({ modkey },            "b",     function ()
        awful.util.spawn("chromium") end,
              {description = "run privacy", group = "launcher"}),

    awful.key({ modkey, "Shift" },  "s",     function ()
        awful.util.spawn("flameshot gui") end,
              {description = "screenshot selected area", group = "launcher"}),

    awful.key({  },  "Print",     function ()
        awful.util.spawn("flameshot full -p /tmp") end,
              {description = "screenshot full area to /tmp", group = "launcher"}),

    awful.key({ modkey, "Shift" },  "e",     function ()
        awful.util.spawn("nwgbar") end,
              {description = "nwgbar (restart, shutdown)", group = "launcher"}),

    awful.key({ },  "XF86MonBrightnessUp",     function ()  
        awful.util.spawn("sudo light -A 10") end,
              {description = "brightness up", group = "laptop"}),

    awful.key({ },  "XF86MonBrightnessDown",     function ()  
        awful.util.spawn("sudo light -U 10") end,
              {description = "brightness down", group = "laptop"}),

  awful.key({ },  "XF86AudioMute",     function ()  
        awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end,
              {description = "mute audio", group = "laptop"}),
awful.key({ },  "XF86AudioMicMute",     function ()  
        awful.util.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle") end,
              {description = "mute mic", group = "laptop"}),
awful.key({ },  "XF86AudioRaiseVolume",     function ()  
        awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%") end,
              {description = "volume raise", group = "laptop"}),
awful.key({ },  "XF86AudioLowerVolume",     function ()  
        awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%") end,
              {description = "volume lower", group = "laptop"}),

    awful.key({ modkey, "Shift" },  "q",     function ()
      awful.spawn.easy_async_with_shell("~/customScripts/offnutEcran.sh") end,
      -- awful.spawn.easy_async_with_shell("betterlockscreen -l") end,
              {description = "offnutEcran", group = "scripts"}),
    awful.key({ modkey, "Shift" },  "w",     function ()
      awful.spawn.easy_async_with_shell("~/customScripts/wpa") end,
              {description = "reload wpa_supplicant", group = "scripts"}),

    --wibox
    awful.key({ modkey }, ";", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end)


})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Down",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Up",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
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
    awful.key({"Mod1",          }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({"Mod4",          }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
 
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
    awful.key({ modkey,   "Shift" }, "Right", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey,  "Shift"  }, "Left", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,    "Shift"       }, "w", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ "Mod1"    },  "Right",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ "Mod1"    }, "Left",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ "Mod1"    },  "Up",     function () awful.client.incwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ "Mod1"    }, "Down",     function () awful.client.incwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --           {description = "increase the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --           {description = "decrease the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --           {description = "increase the number of columns", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --           {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,   "Shift"       }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
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

-- С реддита взял all slave
client.connect_signal(
    "manage",
    function(c)
        if not awesome.startup then
            awful.client.setslave(c)
        end
    end
)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,     "Shift"      }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey}, "q",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),

        awful.key({ modkey,         }, "space",  awful.client.floating.toggle, 
            -- function (c) awful.titlebar.toggle(c) end,
                {description = "toggle floating and titlebar", group = "client"}),

        -- awful.key({ modkey, }, 'space', function (c) awful.titlebar.toggle(c) end,
        --     {description = 'toggle title bar', group = 'client'}),


        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),

        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),

        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),

        awful.key({ modkey,           }, "f",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),

        -- if (awful.layout.get == 0) then
            awful.key({ modkey, "Shift"  }, "Up",   function (c) c:relative_move( 20,  20, -40, -40) end,
                {description = "Increase size in floating", group = "client"}),
            awful.key({ modkey, "Shift"   }, "Down",  function (c) c:relative_move(-20, -20,  40,  40) end,
                {description = "Decrease size in floating", group = "client"}),
        -- end
            

    })
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }
        ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false      }
    }

    -- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }




    awful.titlebar(c).widget = {
        { -- Left
            -- awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            align = "center",
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle

            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)


--     -- Set Firefox(qbit) to always map on the tag named "2" on screen 1.
    ruled.client.append_rule {
        rule       = { class = "qBittorrent"     },
        properties = { screen = 1, tag = "8" }
    }
    ruled.client.append_rule {
        rule       = { class = "discord"     },
        properties = { screen = 1, tag = "9" }
    }

    -- ruled.client.append_rule {
    --     properties = { screen = 1, tag = "1"}
    -- }

    ruled.client.append_rule {
        rule       = { class = "Steam"     },
        properties = { screen = 1, tag = "7", floating = true}
    }
end)

-- }}}

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

-- Swallowing
function is_terminal(c)
    return (c.class and c.class:match("Alacritty")) and true or false
end

function copy_size(c, parent_client)
    if not c or not parent_client then
        return
    end
    if not c.valid or not parent_client.valid then
        return
    end
    c.x=parent_client.x;
    c.y=parent_client.y;
    c.width=parent_client.width;
    c.height=parent_client.height;
end
function check_resize_client(c)
    if(c.child_resize) then
        copy_size(c.child_resize, c)
    end
end

-- client.connect_signal("property::size", check_resize_client)
-- client.connect_signal("property::position", check_resize_client)
-- client.connect_signal("manage", function(c)
--     if is_terminal(c) then
--         return
--     end
--     local parent_client=awful.client.focus.history.get(c.screen, 1)
--     if parent_client and is_terminal(parent_client) then
--         parent_client.child_resize=c
--         c.floating=true
--         copy_size(c, parent_client)
--     end
-- end)
--alternative Version
client.connect_signal("manage", function(c)
    if is_terminal(c) then
        return
    end
    local parent_client=awful.client.focus.history.get(c.screen, 1)
    if parent_client and is_terminal(parent_client) then
        parent_client.child_resize=c
        parent_client.minimized = true

        c:connect_signal("unmanage", function() parent_client.minimized = false end)
        
        c.floating=true
        c.floating=false
        copy_size(c, parent_client)
    end
end)



--Gaps
beautiful.useless_gap = 5
-- -- When client get created
-- client.connect_signal("manage", function(c)
-- local t = awful.screen.focused().selected_tag
--     if #t:clients() > 1 then
--     beautiful.useless_gap = 3
--     else
--     beautiful.useless_gap = 0
--     end
-- end)
-- -- When client get deleted
-- client.connect_signal("unmanage", function(c)
--  local t = awful.screen.focused().selected_tag
--     if #t:clients() > 1 then
--     beautiful.useless_gap = 3
--     else
--     beautiful.useless_gap = 0
--     end
-- end)

-- МОЯ ФУНКЦИЯ ДАДААААДАДА балин,чел.............................
-- client.connect_signal("manage", function(c)
-- local t = awful.tag.find_by_name(awful.screen.focused(), "1")
--     beautiful.useless_gap = 0
-- end)

-- Если одно окно замаксимайзено с помощью обычного вин эфа, то при открытии нового оно не максимайзится, если закрываешь окно, то другое не максимайзится пока что
client.connect_signal("manage", function(c)
local t = awful.screen.focused().selected_tag
    if #t:clients() > 1 then
        for _, c in ipairs(mouse.screen.selected_tag:clients()) do
            c.maximized = false
        end
    end
end)

--Autostart
awful.spawn.with_shell("picom --experimental-backends &")
-- awful.spawn.with_shell("~/customScripts/wpp")
awful.spawn.with_shell("flameshot")
awful.spawn.with_shell("nitrogen --restore")
-- awful.spawn.with_shell("redshift")

