local awful = require "awful"
-- local bling

--All slave с реддита взял
local l = awful.layout.suit
client.connect_signal(
    "manage",
    function(c)
        if not awesome.startup then
            awful.client.setslave(c)
        end
    end
)
-- Новые флоатинги по центру (для мини оповещений пытался найти), не знаю работает ли, это кста тоже с реддита НЕ РАБОТАЕТ
client.connect_signal("request::manage", function(client, context)
    if client.floating and context == "new" then
        client.placement = awful.placement.centered
    end
end)

awful.layout.layouts = {
	l.tile,
	l.floating,
	l.tile.bottom,
}

-- if awful.layout.get == l.floating then

