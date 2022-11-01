local awful = require "awful"
local ruled = require "ruled"




ruled.client.connect_signal("request::rules", function()
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

    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry", "xev" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
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
        properties = { titlebars_enabled = true      }
    }

    ruled.client.append_rule {
        rule       = { class = "discord"     },
        properties = { 
		  tag = screen[1].tags[5]
	    }
    }
    ruled.client.append_rule {
        rule       = {  class = "Chromium"     },
        properties = { 
          tag = screen[1].tags[2]
        }
    }
    ruled.client.append_rule {
        rule       = {  class = "Sublime_text"     },
        properties = { 
          tag = screen[1].tags[1]
        }
    }
    ruled.client.append_rule {
        rule       = {  class = "run_menu"     },
        properties = { 
            floating = true,
            placement = awful.placement.bottom_right,
            width = 1000,
        }
    }

end)
