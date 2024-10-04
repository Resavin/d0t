---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local wibox = require("wibox")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "themes/"
local walls_path = "~/Pictures/"

local beautiful = require("beautiful")
local theme = {}

-- theme.wallpaper = gfs.get_configuration_dir() .. "themes/mansion.jpg"
-- theme.wallpaper = walls_path .. "spring_cropped.jpg"
theme.wallpaper = walls_path .. "elden2.jpeg"

---- Font -----
theme.font = "Iosevka Nerd Font Mono 14"
theme.font_name = "Iosevka Nerd Font Mono"
-- theme.font_name = "Roboto Mono Medium"
theme.font_size = "20"

----- General/default Settings -----

theme.bg_normal = "#151515"
-- theme.bg_normal = "#ffffff" -- I don't know what these are (а, вроде нигде не используется)
-- aaaaa, this works with keybind help
beautiful.hotkeys_bg = "#ffffff" -- This is overwritten by theme.bg_normal. But if I put this line in rc.lua it will override the theme.
theme.bg_focus = "#151515"
theme.bg_urgent = "#151515"
theme.bg_minimize = "#151515"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#c0caf5"
theme.fg_focus = theme.fg_normal
theme.fg_urgent = theme.fg_normal
theme.fg_minimize = theme.fg_normal

theme.useless_gap = dpi(20)
theme.border_width = dpi(0)

----- Colors -----
-- used in not only in widgets
theme.blue = "#70a5eb"
theme.yellow = "#f1cf8a"
theme.green = "#78DBA9"
theme.blue = "#78DBA9"
theme.red = "#e05f65"
theme.crayola = "#C6D2ED"
theme.orange = "#e9a180"
theme.magenta = "#c68aee"

----- Bar -----

theme.bar = "#0B151D"
theme.bar_alt = "#212331" -- Кстати прикольно (я подумал, что он просто дополнительный цвет добавил, а это для разделителей виджетов вроде)
theme.bar = "#192730"

theme.menu_height = dpi(25)
theme.menu_width = dpi(200)

theme.taglist_fg_focus = theme.blue
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_fg_empty = "#404B66"
theme.taglist_bg_focus = theme.blue

theme.tasklist_fg_focus = theme.crayola

theme.titlebar_bg_normal = theme.bar
theme.titlebar_bg_focus = theme.bar

----- Bar (Spring) -----
theme.bar = "#192730"
-- theme.bar_alt = "#4d7677"
theme.bar_alt = "#42574c"

theme.menu_height = dpi(25)
theme.menu_width = dpi(200)

-- Эти штуки снизу походу вообще не используются
theme.taglist_fg_focus = theme.green
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_fg_empty = "#404B66"
theme.taglist_bg_focus = theme.green

theme.tasklist_fg_focus = theme.crayola

theme.titlebar_bg_normal = theme.bar
theme.titlebar_bg_focus = theme.bar
----- Bar (Spring) End -----

-- Ну да походу здесь всё такое просто
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "titlebar/close_unfocus.png"
theme.titlebar_close_button_focus = themes_path .. "titlebar/close.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "layouts/fairhw.png"
theme.layout_fairv = themes_path .. "layouts/fairvw.png"
theme.layout_floating = themes_path .. "layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "layouts/magnifierw.png"
theme.layout_max = themes_path .. "layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "layouts/tileleftw.png"
theme.layout_tile = themes_path .. "layouts/tilew.png"
theme.layout_tiletop = themes_path .. "layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Mic

-- local widgets = {
--     mic = require("ui.mic"),
-- }
-- theme.mic = widgets.mic({
--     timeout = 10,
--     settings = function(self)
--         if self.state == "muted" then
--             self.widget:set_image(theme.widget_micMuted)
--         else
--             self.widget:set_image(theme.widget_micUnmuted)
--         end
--     end
-- })
-- local widget_mic = wibox.widget { theme.mic.widget, layout = wibox.layout.align.horizontal }

-- Set different colors for urgent notifications.
rnotification.connect_signal("request::rules", function()
	rnotification.append_rule({
		-- rule = { urgency = "critical" },
		-- properties = { bg = "#ff0000", fg = "#ffffff" },
		-- opacity = 0,
		properties = {
			widget_template = {
				wibox.widget.textbox("fsd"),
				forced_height = 48,
				halign = "center",
				valign = "center",
				widget = wibox.container.place,
			},
			opacity = 0.1,
		},
	})
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
-- hahahahaahahahahahaha, chel, используй ЭЛЭСПи
