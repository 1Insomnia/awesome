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

function helpers.run_or_raise(match, move, spawn_cmd, spawn_args)
    local matcher = function (c)
        return awful.rules.match(c, match)
    end

    -- Find and raise
    local found = false
    for c in awful.client.iterate(matcher) do
        found = true
        c.minimized = false
        if move then
            c:move_to_tag(mouse.screen.selected_tag)
            client.focus = c
        else
            c:jump_to()
        end
        break
    end

    -- Spawn if not found
    if not found then
        awful.spawn(spawn_cmd, spawn_args)
    end
end

function helpers.scratchpad(match, spawn_cmd, spawn_args)
    local cf = client.focus
    if cf and awful.rules.match(cf, match) then
        cf.minimized = true
    else
        helpers.run_or_raise(match, true, spawn_cmd, spawn_args)
    end
end

return helpers
