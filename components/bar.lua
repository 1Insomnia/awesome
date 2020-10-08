-- Import libraries
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local helpers = require("helpers")


-- Import defaults apps, keys and icons
local apps = require("config.apps")
local keys = require("config.keys")
local icons = require('icons')


-- Import widgets
local task_list = require("widgets.task-list")
local calendar = require("widgets.calendar")
local network = require("widgets.network")()
local updater = require("widgets.package-updater")()


-- Helper function that changes the appearance of progress bars 
local function format_progress_bar(bar)
    bar.forced_width = dpi(100)
    bar.forced_height = dpi(30)
    bar.shape = gears.shape.rectangle
    bar.bar_shape = gears.shape.rectangle
    local w = wibox.widget{
        bar,
        -- direction = 'east',
        margin = dpi(15),
        layout = wibox.layout.stack,
    }
    return w
end

local create_button = function (icon)
    local widget = wibox.widget {
        id = "icon",
        image = icon,
        widget = wibox.widget.imagebox,
    }
    local container = wibox.widget {
        widget,
        margins = dpi(4),
        widget = wibox.container.margin
    }
    return container
end


-- Build widgets
local volume_bar = require("noodle.volume_bar")
local volume = format_progress_bar(volume_bar)
local cpu_bar = require("noodle.cpu_bar")
local cpu = format_progress_bar(cpu_bar)
local ram_bar = require("noodle.ram_bar")
local ram = format_progress_bar(ram_bar)
local battery_bar = require("noodle.battery_bar")
local battery = format_progress_bar(battery_bar)
local music = create_button(icons.music)
local power = create_button(icons.poweroff)


-- Handling Buttons
-- Power 
power:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function () 
        	awesome.emit_signal("show_exit_screen")
    end)
))


-- Music 
music:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, apps.music),
    -- -- Right click - Run or raise pavucontrol
    awful.button({ }, 3, apps.music),
    -- Scroll - Increase / Decrease volume
    awful.button({ }, 4, function () 
        awful.spawn.with_shell("mpc volume +5")
    end),
    awful.button({ }, 5, function () 
        awful.spawn.with_shell("mpc volume -5")
    end)
))


-- Button handling for bar widgets
volume:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function ()
        helpers.volume_control(0)
    end),
    -- -- Right click - Run or raise pavucontrol
    awful.button({ }, 3, apps.volume),
    -- Scroll - Increase / Decrease volume
    awful.button({ }, 4, function () 
        helpers.volume_control(5)
    end),
    awful.button({ }, 5, function () 
        helpers.volume_control(-5)
    end)
))


-- Left/Right click toggle default app monitor
cpu:buttons(gears.table.join(
        awful.button({ }, 1, apps.process_monitor),
        awful.button({ }, 3, apps.process_monitor_gui)
))


-- Left/Right click toggle default app monitor
ram:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.process_monitor),
        awful.button({ }, 3, apps.process_monitor_gui)
))


battery:buttons(gears.table.join(
    awful.button({ }, 1, apps.battery_monitor)
))


-- Tool
local adaptive_tooltip = wibox.widget {
    visible = false,
    top_only = true,
    layout = wibox.layout.stack
}


-- Create tooltip for widget 
local tooltip_counter = 0
local create_tooltip = function(w)
    local tooltip = wibox.widget {
        font = "Recursive Mono Casual 10",
        mode = "outside",
        align = "right",
        widget = wibox.widget.textbox
    }

    tooltip_counter = tooltip_counter + 1
    local index = tooltip_counter

    adaptive_tooltip:insert(index, tooltip)

    w:connect_signal("mouse::enter", function()
        -- Raise tooltip to the top of the stack
        adaptive_tooltip:set(1, tooltip)
        adaptive_tooltip.visible = true
    end)
    w:connect_signal("mouse::leave", function ()
        adaptive_tooltip.visible = false
    end)

    return tooltip
end


-- Build tooltip :TODO: 
local volume_tooltip = create_tooltip(volume_bar)
awesome.connect_signal("evil::volume", function(value, muted)
    volume_tooltip.markup = "The volume is at <span foreground='" .. beautiful.volume_bar_active_color .."'><b>" .. tostring(value) .. "%</b></span>"
    if muted then
        volume_tooltip.markup = volume_tooltip.markup.." and <span foreground='" .. beautiful.volume_bar_active_color .."'><b>muted</b></span>"
    end
end)

local cpu_tooltip = create_tooltip(cpu_bar)
awesome.connect_signal("evil::cpu", function(value)
    cpu_tooltip.markup = "You are using <span foreground='" .. beautiful.cpu_bar_active_color .."'><b>" .. tostring(value) .. "%</b></span> of CPU"
end)

local ram_tooltip = create_tooltip(ram_bar)
awesome.connect_signal("evil::ram", function(value, _)
    ram_tooltip.markup = "You are using <span foreground='" .. beautiful.ram_bar_active_color .."'><b>" .. string.format("%.1f", value / 1000) .. "G</b></span> of memory"
end)

local battery_tooltip = create_tooltip(battery_bar)
awesome.connect_signal("evil::battery", function(value)
    battery_tooltip.markup = "Your battery is at <span foreground='" .. beautiful.battery_bar_active_color .."'><b>" .. tostring(value) .. "%</b></span>"
end)


-- Add handle cursor when hovering
helpers.add_hover_cursor(volume, "hand1")
helpers.add_hover_cursor(cpu, "hand1")
helpers.add_hover_cursor(ram, "hand1")
helpers.add_hover_cursor(battery, "hand1")
helpers.add_hover_cursor(music, "hand1")
helpers.add_hover_cursor(power, "hand1")

local tag_colors_empty = { "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", }

local tag_colors_urgent = {
    beautiful.white,
    beautiful.white,
    beautiful.white,
    beautiful.white,
    beautiful.white,
    beautiful.white,
    beautiful.white,
    beautiful.white,
    beautiful.white,
    beautiful.white

}

local tag_colors_focused = {
    beautiful.red,
    beautiful.magenta,
    beautiful.blue,
    beautiful.cyan,
    beautiful.green,
    beautiful.yellow,
    beautiful.red,
    beautiful.magenta,
    beautiful.blue,
    beautiful.cyan,
}

local tag_colors_occupied = {
    beautiful.red.."55",
    beautiful.magenta.."55",
    beautiful.blue.."55",
    beautiful.cyan.."55",
    beautiful.green.."55",
    beautiful.yellow.."55",
    beautiful.red.."55",
    beautiful.magenta.."55",
    beautiful.blue.."55",
    beautiful.cyan.."55",
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

    -- Create the top bar
    s.mytopwibox = awful.wibar({screen = s, visible = true, ontop = false, type = "dock", position = "top", height = dpi(5)})
    -- Bar placement
    awful.placement.maximize_horizontally(s.mytopwibox)
    s.mytopwibox.bg = "#00000000"

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


-- ===================================================================
-- Bar Creation
-- ===================================================================

local bar = {}

bar.create = function(s)
   local panel = awful.wibar({
      screen = s,
      position = "bottom",
      ontop = true,
      height = dpi(32),
      width = s.geometry.width,
   })

   panel:setup {
      expand = "none",
      layout = wibox.layout.align.horizontal,
      {
         layout = wibox.layout.fixed.horizontal,
         require("widgets.launcher")(),
         music,
         task_list.create(s),
      },
      calendar,
      {
         layout = wibox.layout.fixed.horizontal,
         wibox.layout.margin(wibox.widget.systray(), 0, 0, 3, 3),
         cpu,
         ram,
         volume,
         battery,
         updater,
         network,
         power,
      }
   }


   -- ===================================================================
   -- functionality
   -- ===================================================================

   -- hide panel when client is fullscreen
   local function change_panel_visibility(client)
      panel.ontop = not client.fullscreen
   end

   -- connect panel visibility function to relevant signals
   client.connect_signal("property::fullscreen", change_panel_visibility)
   client.connect_signal("focus", change_panel_visibility)
   client.connect_signal("unfocus", change_panel_visibility)

end


return bar
