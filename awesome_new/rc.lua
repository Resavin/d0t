-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local gfs = require("gears.filesystem")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Error Handling
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)

require "signals.init"
require "conf.init"
require "ui.init"

-- Wallpaper
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

-- Mouse bindings
awful.mouse.append_global_mousebindings({
    -- awful.button({ }, 3, function () mainmenu:toggle() end),
    -- awful.button({ }, 4, awful.tag.viewprev),
    -- awful.button({ }, 5, awful.tag.viewnext),
})

-- Notifications

ruled.notification.connect_signal('request::rules', function()
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

-- Swallowing
-- function is_terminal(c)
--     return (c.class and c.class:match("Alacritty")) and true or false
-- end

-- function copy_size(c, parent_client)
--     if not c or not parent_client then
--         return
--     end
--     if not c.valid or not parent_client.valid then
--         return
--     end
--     c.x=parent_client.x;
--     c.y=parent_client.y;
--     c.width=parent_client.width;
--     c.height=parent_client.height;
-- end
-- function check_resize_client(c)
--     if(c.child_resize) then
--         copy_size(c.child_resize, c)
--     end
-- end

-- client.connect_signal("manage", function(c)
--     if is_terminal(c) then
--         return
--     end
--     local parent_client=awful.client.focus.history.get(c.screen, 1)
--     if parent_client and is_terminal(parent_client) then
--         parent_client.child_resize=c
--         parent_client.minimized = true

--         c:connect_signal("unmanage", function() parent_client.minimized = false end)
        
--         c.floating=true
--         c.floating=false
--         copy_size(c, parent_client)
--     end
-- end)