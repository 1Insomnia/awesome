local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set colors
local active_color = beautiful.blue 
local background_color = beautiful.bg_dim

local battery_bar = wibox.widget{
  max_value     = 100,
  value         = 50,
    forced_height = dpi(30),
    margins       = {
      top = dpi(7),
      left = dpi(7),
      right = dpi(7),
      bottom = dpi(7),
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

awesome.connect_signal("evil::battery", function(value)
    battery_bar.value = value
end)

return battery_bar
