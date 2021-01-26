-------------------------------------------------
-- Battery Arc Widget for Awesome Window Manager
-- Shows the battery level of the laptop
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/batteryarc-widget

-- @author Pavel Makhov
-- @copyright 2019 Pavel Makhov
-------------------------------------------------

-- local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
-- local wibox = require("wibox")
-- local watch = require("awful.widget.watch")

local HOME = os.getenv("HOME")


function show_screenshot()
    naughty.notify {
        icon = HOME .. "/last.screenshot.png",
        icon_size = 150,
        text = "Don't forget brag me\n", -- switch text and title
        title = "Screenshot taken!!\n",
        timeout = 5,   -- show the warning for a longer time
        hover_timeout = 0.5,
        position = "top_left",
        bg = "#080808",
        fg = beautiful.fg_normal,
	font = "xos4 Terminus 10",
        width = 330,
        border_width = 1,
        border_color = beautiful.fg_normal,
    }
end


function show_volumeup()
    naughty.notify {
        icon = HOME .. "/.config/awesome/awesome-wm-widgets/notifications-widget/volume-up.png",
        icon_size = 100,
        text = "Volume was increased 5%", -- switch text and title
        title = "Volume Up!\n",
        timeout = 5,   -- show the warning for a longer time
        hover_timeout = 0.5,
        position = "top_left",
        bg = "#080808",
        fg = beautiful.fg_normal,
    font = "xos4 Terminus 10",
        width = 330,
        border_width = 1,
        border_color = beautiful.fg_normal,
    }
end

function show_volumedown()
    naughty.notify {
        icon = HOME .. "/.config/awesome/awesome-wm-widgets/notifications-widget/volume-down.png",
        icon_size = 100,
        text = "Volume was decreased 5%", -- switch text and title
        title = "Volume Down!\n",
        timeout = 5,   -- show the warning for a longer time
        hover_timeout = 0.5,
        position = "top_left",
        bg = "#080808",
        fg = beautiful.fg_normal,
    font = "xos4 Terminus 10",
        width = 330,
        border_width = 1,
        border_color = beautiful.fg_normal,
    }
end

--[[
function show_screenshot()
    naughty.notify {
        icon = HOME .. "/.config/awesome/awesome-wm-widgets/batteryarc-widget/spaceman.jpg",
        icon_size = 100,
        text = "Battery is dying...\n", -- switch text and title
        title = "Houston, we have a problem\n",
        timeout = 25,   -- show the warning for a longer time
        hover_timeout = 0.5,
        position = "top_left",
        bg = "#080808",
        fg = beautiful.widget_red,
    font = "xos4 Terminus 10",
        width = 330,
        border_width = 1,
        border_color = beautiful.fg_normal,
    }
end


function show_screenshot()
    naughty.notify {
        icon = HOME .. "/.config/awesome/awesome-wm-widgets/batteryarc-widget/spaceman.jpg",
        icon_size = 100,
        text = "Battery is dying...\n", -- switch text and title
        title = "Houston, we have a problem\n",
        timeout = 25,   -- show the warning for a longer time
        hover_timeout = 0.5,
        position = "top_left",
        bg = "#080808",
        fg = beautiful.widget_red,
    font = "xos4 Terminus 10",
        width = 330,
        border_width = 1,
        border_color = beautiful.fg_normal,
    }
end
]]----
