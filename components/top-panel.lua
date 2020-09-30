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
local volume = require("components.volume")
-- import widgets
local task_list = require("widgets.task-list")
local tag_list = require("widgets.tag-list")

-- define module table
local ram_bar_color = beautiful.red
local function rounded_bar(color)
    return wibox.widget {
        max_value     = 100,
        value         = 0,
        forced_height = dpi(10),
        forced_width  = dpi(60),
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

-- Volume bar
local volume_bar_color = beautiful.green
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
local battery_bar_color = beautiful.blue
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
      nil,
      {
         layout = wibox.layout.fixed.horizontal,
         wibox.layout.margin(wibox.widget.systray(), 0, 0, 3, 3),
         ram_bar,
         battery_bar,
         volume_bar,
         require("widgets.calendar"),
         require("widgets.bluetooth"),
         require("widgets.network")(),
         require("widgets.battery"),
         require("widgets.layout-box")
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
