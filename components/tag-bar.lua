local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local keys = require("config.keys")

local tag_colors_empty = { "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", }

local tag_colors_urgent = {
    "#FF0",
    beautiful.fg_normal,
    beautiful.fg_normal,
    beautiful.fg_normal,
    beautiful.fg_normal,
    beautiful.fg_normal,
    beautiful.fg_normal,
    beautiful.fg_normal,
    beautiful.fg_normal,
    beautiful.fg_normal
}

local tag_colors_focused = {
    beautiful.red,
    beautiful.green,
    beautiful.yellow,
    beautiful.blue,
    beautiful.red,
    beautiful.blue,
    beautiful.green,
    beautiful.yellow,
    beautiful.red,
    beautiful.blue,
}

local tag_colors_occupied = {
    beautiful.red,
    beautiful.red,
    beautiful.red,
    beautiful.red,
    beautiful.red,
    beautiful.red,
    beautiful.red,
    beautiful.red,
    beautiful.red,
    beautiful.red,
}


-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index)
    if tag.selected then
        item.bg = tag_colors_focused[index]
    elseif tag.urgent then
        item.bg = tag_colors_urgent[index]
    elseif #tag:clients() > 0 then
        item.bg = tag_colors_occupied[index]
    else
        item.bg = tag_colors_empty[index]
    end
end

awful.screen.connect_for_each_screen(function(s)
    -- Create a taglist for every screen
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = keys.taglist_buttons,
        layout = wibox.layout.flex.horizontal,
        widget_template = {
            widget = wibox.container.background,
            create_callback = function(self, tag, index, _)
                update_taglist(self, tag, index)
            end,
            update_callback = function(self, tag, index, _)
                update_taglist(self, tag, index)
            end,
        }
    }
    -- Create the taglist wibox
    s.mytopwibox = awful.wibar({
        screen = s,
        visible = true,
        ontop = false,
        type = "dock",
        position = "top",
        height = dpi(12),
        -- position = "left",
        -- width = dpi(6),
        bg = beautiful.bg_normal,
    })

    s.mytopwibox:setup {
        widget = s.mytaglist,
    }
    -- Place bar at the bottom and add margins
    -- awful.placement.bottom(s.mywibox, {margins = beautiful.screen_margin * 2})
    -- Also add some screen padding so that clients do not stick to the bar
    -- For "awful.wibar"
    -- s.padding = { bottom = s.padding.bottom + beautiful.screen_margin * 2 }
    -- For "wibox"
    -- s.padding = { bottom = s.mywibox.height + beautiful.screen_margin * 2 }

end)
-- We have set the wibar(s) to be ontop, but we do not want it to be above fullscreen clients
