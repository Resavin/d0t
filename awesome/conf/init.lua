local beautiful = require("beautiful")
local gfs = require("gears.filesystem")
local awful = require("awful")

beautiful.init(gfs.get_configuration_dir() .. "themes/theme.lua")

require("conf.layout")
require("conf.keybind")
require("conf.rules")
require("conf.client")

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- local startup_script = [[
-- killall picom &
-- xset r rate 200 15 &
-- picom --config $HOME/.config/picom/picom.conf &
-- redshift -x &
-- killall .redshift-wrapp &
-- redshift &
-- sudo python /home/byakuya/.local/bin/customScripts/pywall &
-- -- microsoft-edge &
-- ]]

awful.spawn.with_shell(startup_script)
