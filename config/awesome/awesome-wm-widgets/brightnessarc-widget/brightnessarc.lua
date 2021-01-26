-------------------------------------------------
-- Brightness Widget for Awesome Window Manager
-- Shows the brightness level of the laptop display
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/brightnessarc-widget

-- @author Pavel Makhov
-- @copyright 2019 Pavel Makhov
-------------------------------------------------


local wibox = require("wibox")
local watch = require("awful.widget.watch")
local beautiful = require("beautiful")
local spawn = require("awful.spawn")

local PATH_TO_ICON = "/usr/share/icons/icons-hash/status/display-brightness-symbolic.svg"
local GET_BRIGHTNESS_CMD = "light -G" -- "xbacklight -get"
local INC_BRIGHTNESS_CMD = "light -A 5" -- "xbacklight -inc 5"
local DEC_BRIGHTNESS_CMD = "light -U 5" -- "xbacklight -dec 5"

local icon = {
    id = "icon",
    image = PATH_TO_ICON,
    resize = true,
    widget = wibox.widget.imagebox,
}

local brightnessarc = wibox.widget {
    icon,
    max_value = 1,
    thickness = 2,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 16,
    forced_width = 16,
    bg = "#ffffff11",
    paddings = 2,
    widget = wibox.container.arcchart

}

local update_widget = function(widget, stdout)
    local brightness_level = string.match(stdout, "(%d?%d?%d?)")
    brightness_level = tonumber(string.format("% 3d", brightness_level))
    widget.value = brightness_level / 100;
    widget.colors =  { beautiful.widget_main_color }
end,

brightnessarc:connect_signal("button::press", function(_, _, _, button)
    if (button == 4) then spawn(INC_BRIGHTNESS_CMD, false)
    elseif (button == 5) then spawn(DEC_BRIGHTNESS_CMD, false)
    end

end)

brightnessarc:connect_signal("button::press", function() watch(GET_BRIGHTNESS_CMD, 1000, update_widget, brightnessarc) end)


watch(GET_BRIGHTNESS_CMD, 1, update_widget, brightnessarc)

return brightnessarc
