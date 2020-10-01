local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local helpers = {}

-- Create rounded rectangle shape (in one line)
helpers.rrect = function(radius)
  return function(c, width, height)
    gears.shape.rounded_rect(c, width, height, radius)
  end
end

-- Colorize text
helpers.colorize_text = function(text, color)
    return "<span foreground='" .. color .."'>" .. text .. "</span>"
end

-- Tag back and forth:
-- If you try to focus the tag you are already at, go back to the previous tag.
-- Useful for quick switching after for example checking an incoming chat
-- message at tag 2 and coming back to your work at tag 1 with the same
-- keypress. 
function helpers.tag_back_and_forth(tag_index)
    local s = mouse.screen
    local tag = s.tags[tag_index]
    if tag then
        if tag == s.selected_tag then
            awful.tag.history.restore()
        else
            tag:view_only()
        end
    end
end

-- Volume
function helpers.volume_control(step)
    local cmd
    if step == 0 then
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    else
        sign = step > 0 and "+" or ""
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ "..sign..tostring(step).."%"
    end
    awful.spawn.with_shell(cmd)
end

return helpers
