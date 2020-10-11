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
local battery = require("widgets.battery")()
local layoutbox = require("widgets.layout-box")

local volume_icon = wibox.widget.imagebox(icons.volume)
volume_icon.resize = true
volume_icon.forced_width = icon_size
volume_icon.forced_height = icon_size

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

-- Helpers function to create a box with icon and bar
local create_box = function(icon, bar)
    local box = wibox.widget {
        icon, 
        bar,
        spacing = dpi(5),
        layout = wibox.layout.fixed.horizontal
    }
    return box
end

-- Build widgets
local volume_bar = require("noodle.volume_bar")
local volume = format_progress_bar(volume_bar)

-- Buttons widgets
local dashboard = create_button(icons.awesome_menu)
local search = create_button(icons.search)
local music = create_button(icons.music)
local power = create_button(icons.poweroff)


local volume_box = create_box(volume_icon, volume)

-- Handling Buttons
-- Power 
power:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function () 
        	awesome.emit_signal("show_exit_screen")
    end)
))

dashboard:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function () 
        dashboard_show()	
    end),
    awful.button({ }, 3, function () 
        sidebar_show()	
    end)
))

search:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function () 
        awful.spawn.with_shell("rofi fuzzy -show combi")	
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
volume_box:buttons(gears.table.join(
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

-- Add handle cursor when hovering
helpers.add_hover_cursor(volume, "hand1")
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
         dashboard,
         search,
         music,
         task_list.create(s),
      },
      calendar,
      {
         layout = wibox.layout.fixed.horizontal,
         wibox.layout.margin(wibox.widget.systray(), 0, 0, 3, 3),
         volume_box,
         battery,
         updater,
         network,
         layoutbox,
         power
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
