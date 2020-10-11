local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set colors
local active_color = x.color3
local background_color = beautiful.bg_normal

local temperature_bar = wibox.widget{
  max_value     = 100,
  value         = 50,
  forced_height = dpi(10),
  margins       = {
    top = dpi(10),
    bottom = dpi(10),
  },
  forced_width  = dpi(200),
  shape         = gears.shape.rounded_bar,
  bar_shape     = gears.shape.rounded_bar,
  color         = active_color,
  background_color = background_color,
  border_width  = 0,
  border_color  = beautiful.border_color,
  widget        = wibox.widget.progressbar,
}

awesome.connect_signal("evil::temperature", function(value)
    temperature_bar.value = value
end)

return temperature_bar
