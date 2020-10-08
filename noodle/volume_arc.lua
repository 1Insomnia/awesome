local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local icons = require("icons")

local active_color = {
    type = 'linear',
    from = {0, 0},
    to = {200, 50}, -- replace with w,h later
    stops = {{0, x.color2}, {0.75, x.color1}}
}

local icon = {
    id = "icon",
    image = icons.volume,
    resize = true,
    widget = wibox.widget.imagebox
}

local volume_arc = wibox.widget {
    icon,
    max_value = 100,
    thickness = 8,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 100,
    rounded_edge = true,
    forced_width = 100,
    bg = beautiful.xcolor0,
    paddings = 10,
    colors = {active_color},
    widget = wibox.container.arcchart
}

awesome.connect_signal("evil::volume", function(volume, muted)
    if muted then
        volume_arc.bg = beautiful.xcolor1
    else
        volume_arc.bg = beautiful.xcolor0
    end

    volume_arc.value = volume
end)

return volume_arc
