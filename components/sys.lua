local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local apps = require("config.apps")

local helpers = require("helpers")

local function format_progress_bar(bar)
    -- Since we will rotate the bars 90 degrees, width and height are reversed
    bar.forced_width = dpi(70)
    bar.forced_height = dpi(30)
    bar.shape = gears.shape.rounded_bar
    bar.bar_shape = gears.shape.rectangle
    local w = wibox.widget{
        bar,
        direction = 'east',
        layout = wibox.container.rotate,
    }
    return w
end

local temperature_bar = require("noodle.temperature_bar")
local temperature = format_progress_bar(temperature_bar)
temperature:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.temperature_monitor)
))

local cpu_bar = require("noodle.cpu_bar")
local cpu = format_progress_bar(cpu_bar)

cpu:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.process_monitor),
        awful.button({ }, 3, apps.process_monitor_gui)
))

local ram_bar = require("noodle.ram_bar")
local ram = format_progress_bar(ram_bar)

ram:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.process_monitor),
        awful.button({ }, 3, apps.process_monitor_gui)
))


local brightness_bar = require("noodle.brightness_bar")
local brightness = format_progress_bar(brightness_bar)

brightness:buttons(
    gears.table.join(
        -- Left click - Toggle redshift
        awful.button({ }, 1, apps.night_mode),
        -- Right click - Reset brightness (Set to max)
        awful.button({ }, 3, function ()
            awful.spawn.with_shell("light -S 100")
        end),
        -- Scroll up - Increase brightness
        awful.button({ }, 4, function ()
            awful.spawn.with_shell("light -A 10")
        end),
        -- Scroll down - Decrease brightness
        awful.button({ }, 5, function ()
            awful.spawn.with_shell("light -U 10")
        end)
))

local volume_bar = require("noodle.volume_bar")
local volume = format_progress_bar(volume_bar)

volume:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function ()
        helpers.volume_control(0)
    end),
    -- Right click - Run or raise pavucontrol
    awful.button({ }, 3, apps.volume),
    -- Scroll - Increase / Decrease volume
    awful.button({ }, 4, function () 
        helpers.volume_control(2)
    end),
    awful.button({ }, 5, function () 
        helpers.volume_control(-2)
    end)
))

-- Create tooltip widget
-- It should change depending on what the user is hovering over
local adaptive_tooltip = wibox.widget {
    visible = false,
    top_only = true,
    layout = wibox.layout.stack
}

-- Create tooltip for widget w
local tooltip_counter = 0
local create_tooltip = function(w)
    local tooltip = wibox.widget {
        font = "sans medium 10",
        align = "center",
        valign = "center",
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

local brightness_tooltip = create_tooltip(brightness_bar)
awesome.connect_signal("evil::brightness", function(value)
    brightness_tooltip.markup = "Your screen is <span foreground='" .. beautiful.brightness_bar_active_color .."'><b>" .. tostring(value) .. "%</b></span> bright"
end)

local cpu_tooltip = create_tooltip(cpu_bar)
awesome.connect_signal("evil::cpu", function(value)
    cpu_tooltip.markup = "You are using <span foreground='" .. beautiful.cpu_bar_active_color .."'><b>" .. tostring(value) .. "%</b></span> of CPU"
end)

local ram_tooltip = create_tooltip(ram_bar)
awesome.connect_signal("evil::ram", function(value, _)
    ram_tooltip.markup = "You are using <span foreground='" .. beautiful.ram_bar_active_color .."'><b>" .. string.format("%.1f", value / 1000) .. "G</b></span> of memory"
end)

local volume_tooltip = create_tooltip(volume_bar)
awesome.connect_signal("evil::volume", function(value, muted)
    volume_tooltip.markup = "The volume is at <span foreground='" .. beautiful.volume_bar_active_color .."'><b>" .. tostring(value) .. "%</b></span>"
    if muted then
        volume_tooltip.markup = volume_tooltip.markup.." and <span foreground='" .. beautiful.volume_bar_active_color .."'><b>muted</b></span>"
    end
end)

local temperature_tooltip = create_tooltip(temperature_bar)
awesome.connect_signal("evil::temperature", function(value)
    temperature_tooltip.markup = "Your CPU temperature is at <span foreground='" .. beautiful.temperature_bar_active_color .."'><b>" .. tostring(value) .. "°C</b></span>"
end)


sysbar = wibox({visible = false, ontop = true, type = "dock", screen = 1})
sysbar.bg = beautiful.bg_normal
sysbar.fg = beautiful.fg_normal
sysbar.height = dpi(500)
sysbar.width = dpi(300)


sysbar:buttons(gears.table.join(
    -- Middle click - Hide sysbar
    awful.button({ }, 2, function ()
        sysbar_hide()
    end)
))

sysbar_show = function()
    sysbar.visible = true
end

sysbar_hide = function()
    -- Do not hide it if prompt is active
    if not prompt_is_active() then
        sysbar.visible = false
    end
end

sysbar_toggle = function()
    if sysbar.visible then
        sysbar_hide()
    else
        sysbar.visible = true
    end
end
-- if user.sysbar.hide_on_mouse_leave then
--     sysbar:connect_signal("mouse::leave", function ()
--         sysbar_hide()
--     end)
-- end

-- sysbar:setup {
--     {
--         volume,
--         cpu,
--         temperature,
--         ram,
--         brightness,
--         spacing = dpi(5),
--         layout = wibox.layout.fixed.horizontal
-- },
--         expand = "none",
--         layout = wibox.layout.align.horizontal
-- }
