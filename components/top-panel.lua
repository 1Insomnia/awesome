--      ████████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--         ██║   ██║   ██║██████╔╝    ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--         ██║   ██║   ██║██╔═══╝     ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--         ██║   ╚██████╔╝██║         ██║     ██║  ██║██║ ╚████║███████╗███████╗
--         ╚═╝    ╚═════╝ ╚═╝         ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi
local xresources = require("beautiful.xresources")
local helpers = require("helpers")
-- Local scripts
local volume = require("components.volume")

-- import widgets
local task_list = require("widgets.task-list")
local tag_list = require("widgets.tag-list")
local calendar = require("widgets.calendar")
local network = require("widgets.network")()
local battery = require("widgets.battery")
local bluetooth = require("widgets.bluetooth")
local layout_box = require("widgets.layout-box")

-- Bar color
local ram_bar_color = beautiful.red
local volume_bar_color = beautiful.green
local battery_bar_color = beautiful.blue
-- define module table
local function rounded_bar(color)
    return wibox.widget {
        max_value     = 100,
        value         = 0,
        forced_height = dpi(10),
        forced_width  = dpi(100),
        margins       = {
          top = dpi(10),
          bottom = dpi(10),
          left = dpi(10),
          right = dpi(10),
        },
        shape         = gears.shape.rectangle,
        border_width  = 0,
        color         = color,
        background_color = beautiful.bg_bar,
        border_color  = beautiful.border_color,
        widget        = wibox.widget.progressbar,
    }
end
-- Helper function that creates a button widget
local create_button = function (symbol, color, bg_color, hover_color)
    local widget = wibox.widget {
        font = "icomoon 14",
        align = "center",
        id = "text_role",
        valign = "center",
        markup = helpers.colorize_text(symbol, color),
        widget = wibox.widget.textbox()
    }

    local section = wibox.widget {
        widget,
        forced_width = dpi(40),
        bg = bg_color,
        widget = wibox.container.background
    }

    -- Hover animation
    section:connect_signal("mouse::enter", function ()
        section.bg = hover_color
    end)
    section:connect_signal("mouse::leave", function ()
        section.bg = bg_color
    end)

    -- helpers.add_hover_cursor(section, "hand1")

    return section
end

-- Logout button
local exit = create_button("", beautiful.red, beautiful.bg_normal .."C0", beautiful.white .."E0")
exit:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awesome.emit_signal("show_exit_screen")
    end)
))

-- Volume bar
local volume_bar = rounded_bar(volume_bar_color)
function update_volume_bar(vol, mute)
    volume_bar.value = vol
    if mute then
        volume_bar.color = beautiful.xforeground
    else
        volume_bar.color = volume_bar_color
    end
end

volume_bar:buttons(gears.table.join(
    awful.button({ }, 4, volume.volume_up),
    awful.button({ }, 5, volume.volume_down),
    awful.button({ }, 1, volume.volume_mute)))

awesome.connect_signal("evil::volume", update_volume_bar)

-- Init widget state
volume.get_volume_state(update_volume_bar)

-- Update widget when headphones conneted
awesome.connect_signal("acpi::headphones", function()
    volume.get_volume_state(update_volume_bar)
end)

-- Ram bar
local ram_bar = rounded_bar(ram_bar_color)

awful.widget.watch("cat /proc/meminfo", 5, function(widget, stdout)
  local total = stdout:match("MemTotal:%s+(%d+)")
  local free = stdout:match("MemFree:%s+(%d+)")
  local buffers = stdout:match("Buffers:%s+(%d+)")
  local cached = stdout:match("Cached:%s+(%d+)")
  local srec = stdout:match("SReclaimable:%s+(%d+)")
  local used_kb = total - free - buffers - cached - srec
  widget.value = used_kb / total * 100
end, ram_bar)

-- Battery bar
local battery_bar = rounded_bar(battery_bar_color)

awful.widget.watch("cat /sys/class/power_supply/BAT1/capacity", 30, function(widget, stdout)
    local capacity = stdout:match("^%s*(.-)%s*$")
    widget.value = tonumber(capacity)
end, battery_bar)

-- ===================================================================
-- Bar Creation
-- ===================================================================

local top_panel = {}

top_panel.create = function(s)
   local panel = awful.wibar({
      screen = s,
      position = "top",
      ontop = true,
      height = dpi(32),
      width = s.geometry.width,
   })

   panel:setup {
      expand = "none",
      layout = wibox.layout.align.horizontal,
      {
         layout = wibox.layout.fixed.horizontal,
         tag_list.create(s),
         task_list.create(s),
      },
      calendar,
      {
         layout = wibox.layout.fixed.horizontal,
         wibox.layout.margin(wibox.widget.systray(), 0, 0, 3, 3),
         ram_bar,
         battery_bar,
         volume_bar,
         bluetooth,
         network,
         battery,
         exit,
         layout_box,
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

return top_panel
