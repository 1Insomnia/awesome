local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local apps = require("config.apps")
local icons = require("icons")

local helpers = require("helpers")

local icon_size = dpi(64)

local volume_icon = wibox.widget.imagebox(icons.volume)
volume_icon.resize = true
volume_icon.forced_width = icon_size
volume_icon.forced_height = icon_size 

local ram_icon = wibox.widget.imagebox(icons.ram)
ram_icon.resize = true
ram_icon.forced_width = icon_size
ram_icon.forced_height = icon_size

local brightness_icon = wibox.widget.imagebox(icons.brightness)
brightness_icon.resize = true
brightness_icon.forced_width = icon_size
brightness_icon.forced_height = icon_size

local cpu_icon = wibox.widget.imagebox(icons.cpu)
cpu_icon.resize = true
cpu_icon.forced_width = icon_size
cpu_icon.forced_height = icon_size

local temperature_icon = wibox.widget.imagebox(icons.temperature)
temperature_icon.resize = true
temperature_icon.forced_width = icon_size
temperature_icon.forced_height = icon_size

local battery_icon = wibox.widget.imagebox(icons.battery)
battery_icon.resize = true
battery_icon.forced_width = icon_size
battery_icon.forced_height = icon_size

-- Helper function that changes the appearance of progress bars and their icons
local function format_progress_bar(bar)
    -- Since we will rotate the bars 90 degrees, width and height are reversed
    bar.forced_width = dpi(120)
    bar.forced_height = dpi(42)
    bar.shape = gears.shape.rectangle
    bar.bar_shape = gears.shape.rectangle
    local w = wibox.widget{
        bar,
        direction = 'east',
        layout = wibox.layout.stack,
    }
    return w
end

local create_box = function(icon, bar)
    local box = wibox.widget {
        icon, 
        bar,
        spacing = dpi(5),
        layout = wibox.layout.fixed.horizontal
    }
    return box
end

local create_button = function (icon)
    local widget = wibox.widget {
        id = "icon",
        image = icon,
        resize = true,
        forced_height = icon_size - 10,
        forced_width = icon_size - 10, 
        widget = wibox.widget.imagebox,
    }
    local container = wibox.widget {
        widget,
        margins = dpi(5),
        widget = wibox.container.margin
    }
    return container
end

local battery_bar = require("noodle.battery_bar")
local battery = format_progress_bar(battery_bar)
local battery_box = create_box(battery_icon, battery)
battery_box:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.battery_monitor)
))

local temperature_bar = require("noodle.temperature_bar")
local temperature = format_progress_bar(temperature_bar)
local temperature_box = create_box(temperature_icon, temperature)
temperature:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.temperature_monitor)
))

local cpu_bar = require("noodle.cpu_bar")
local cpu = format_progress_bar(cpu_bar)
local cpu_box = create_box(cpu_icon, cpu)

cpu_box:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.process_monitor),
        awful.button({ }, 3, apps.process_monitor_gui)
))

local ram_bar = require("noodle.ram_bar")
local ram = format_progress_bar(ram_bar)
local ram_box = create_box(ram_icon, ram)

ram_box:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.process_monitor),
        awful.button({ }, 3, apps.process_monitor_gui)
))

local brightness_bar = require("noodle.brightness_bar")
local brightness = format_progress_bar(brightness_bar)
local brightness_box = create_box(brightness_icon, brightness)

brightness_box:buttons(
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
local volume_box = create_box(volume_icon, volume_bar)

volume_box:buttons(gears.table.join(
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

local close = create_button(icons.close)
close:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function () 
        sidebar_hide()
    end)
))

local hours = wibox.widget.textclock("%H")
local minutes = wibox.widget.textclock("%M")

local make_little_dot = function (color)
    return wibox.widget{
        bg = color,
        forced_width = dpi(10),
        forced_height = dpi(10),
        shape = helpers.rrect(dpi(2)),
        widget = wibox.container.background
    }
end

local time = {
    {
        font = "Rec Mono Casual bold 44",
        align = "right",
        valign = "top",
        widget = hours
    },
    {
        nil,
        {
            make_little_dot(x.color1),
            make_little_dot(x.color4),
            make_little_dot(x.color5),
            spacing = dpi(10),
            widget = wibox.layout.fixed.vertical
        },
        expand = "none",
        widget = wibox.layout.align.vertical
    },
    {
        font = "biotif extra bold 44",
        align = "left",
        valign = "top",
        widget = minutes
    },
    spacing = dpi(20),
    layout = wibox.layout.fixed.horizontal
}

-- Day of the week (dotw)
local dotw = require("noodle.day_of_the_week")
local day_of_the_week = wibox.widget {
    nil,
    dotw,
    expand = "none",
    layout = wibox.layout.align.horizontal
}

-- Mpd
local mpd_buttons = require("noodle.mpd_buttons")
local mpd_song = require("noodle.mpd_song")
local mpd_widget_children = mpd_song:get_all_children()
local mpd_title = mpd_widget_children[1]
local mpd_artist = mpd_widget_children[2]
mpd_title.font = "sans medium 14"
mpd_artist.font = "sans medium 10"

-- Set forced height in order to limit the widgets to one line.
-- Might need to be adjusted depending on the font.
mpd_title.forced_height = dpi(22)
mpd_artist.forced_height = dpi(16)

mpd_song:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("mpc -q toggle")
    end),
    awful.button({ }, 3, apps.music),
    awful.button({ }, 4, function ()
        awful.spawn.with_shell("mpc -q prev")
    end),
    awful.button({ }, 5, function ()
        awful.spawn.with_shell("mpc -q next")
    end)
))

local search_icon = wibox.widget {
    font = "icomoon bold 10",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox()
}

local reset_search_icon = function ()
    search_icon.markup = helpers.colorize_text("", x.color3)
end
reset_search_icon()

local search_text = wibox.widget {
    -- markup = helpers.colorize_text("Search", x.color8),
    align = "center",
    valign = "center",
    font = "sans 9",
    widget = wibox.widget.textbox()
}

local search_bar = wibox.widget {
    shape = gears.shape.rounded_bar,
    bg = x.color0,
    widget = wibox.container.background()
}

local search = wibox.widget{
    -- search_bar,
    {
        {
            search_icon,
            {
                search_text,
                bottom = dpi(2),
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.horizontal
        },
        left = dpi(15),
        widget = wibox.container.margin
    },
    forced_height = dpi(35),
    forced_width = dpi(200),
    shape = gears.shape.rounded_bar,
    bg = x.color0,
    widget = wibox.container.background()
    -- layout = wibox.layout.stack
}

local function generate_prompt_icon(icon, color)
    return "<span font='icomoon 10' foreground='" .. color .."'>" .. icon .. "</span> "
end

function sidebar_activate_prompt(action)
    sidebar.visible = true
    search_icon.visible = false
    local prompt
    if action == "run" then
        prompt = generate_prompt_icon("", x.color2)
    elseif action == "web_search" then
        prompt = generate_prompt_icon("", x.color4)
    end
    helpers.prompt(action, search_text, prompt, function()
        search_icon.visible = true
        if mouse.current_wibox ~= sidebar then
            sidebar.visible = false
        end
    end)
end

local prompt_is_active = function ()
    -- The search icon is hidden and replaced by other icons
    -- when the prompt is running
    return not search_icon.visible
end

search:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        sidebar_activate_prompt("run")
    end),
    awful.button({ }, 3, function ()
        sidebar_activate_prompt("web_search")
    end)
))

-- File system bookmarks
local function create_bookmark(name, path)
    local original_color = x.color1
    local hover_color = x.color8

    local bookmark = wibox.widget.textbox()
    bookmark.font = "sans bold 16"
    -- bookmark.text = wibox.widget.textbox(name:sub(1,1):upper()..name:sub(2))
    bookmark.markup = helpers.colorize_text(name, original_color)
    bookmark.align = "center"
    bookmark.valign = "center"

    -- Buttons
    bookmark:buttons(gears.table.join(
        awful.button({ }, 1, function ()
            awful.spawn.with_shell(user.file_manager.." "..path)
            dashboard_hide()
        end),
        awful.button({ }, 3, function ()
            awful.spawn.with_shell(user.terminal.." -e 'ranger' "..path)
            dashboard_hide()
        end)
    ))

    -- Hover effect
    bookmark:connect_signal("mouse::enter", function ()
        bookmark.markup = helpers.colorize_text(name, hover_color)
    end)
    bookmark:connect_signal("mouse::leave", function ()
        bookmark.markup = helpers.colorize_text(name, original_color)
    end)

    helpers.add_hover_cursor(bookmark, "hand1")

    return bookmark
end

local bookmarks = wibox.widget {
    create_bookmark("HOME", os.getenv("HOME")),
    create_bookmark("DOWNLOADS", user.dirs.downloads),
    create_bookmark("MUSIC", user.dirs.music),
    create_bookmark("TMP", user.dirs.tmp),
    create_bookmark("WALLPAPERS", user.dirs.walls),
    spacing = dpi(10),
    layout = wibox.layout.fixed.vertical
}

-- URLs
local function create_url(name, path)
    local original_color = x.color4
    local hover_color = x.color12

    local url = wibox.widget.textbox()
    url.font = "sans bold 16"
    -- url.text = wibox.widget.textbox(name:sub(1,1):upper()..name:sub(2))
    url.markup = helpers.colorize_text(name, original_color)
    url.align = "center"
    url.valign = "center"

    -- Buttons
    url:buttons(
        gears.table.join(
            awful.button({ }, 1, function ()
                awful.spawn(user.browser.." "..path)
                dashboard_hide()
            end),
            awful.button({ }, 3, function ()
                awful.spawn(user.browser.." -new-window "..path)
                dashboard_hide()
            end)
    ))

    -- Hover effect
    url:connect_signal("mouse::enter", function ()
        url.markup = helpers.colorize_text(name, hover_color)
    end)
    url:connect_signal("mouse::leave", function ()
        url.markup = helpers.colorize_text(name, original_color)
    end)

    helpers.add_hover_cursor(url, "hand1")

    return url
end

local urls = wibox.widget {
    create_url("UNIXPORN", "reddit.com/r/unixporn"),
    create_url("FRANCE", "reddit.com/r/france"),
    create_url("REDDIT", "reddit.com"),
    create_url("GITHUB", "github.com/r0b0tx"),
    spacing = dpi(10),
    layout = wibox.layout.fixed.vertical
}


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

-- Add clickable mouse effects on some widgets
-- helpers.add_hover_cursor(cpu, "hand1")
-- helpers.add_hover_cursor(ram, "hand1")
-- helpers.add_hover_cursor(temperature, "hand1")
-- helpers.add_hover_cursor(volume, "hand1")
-- helpers.add_hover_cursor(brightness, "hand1")
-- helpers.add_hover_cursor(mpd_song, "hand1")
-- helpers.add_hover_cursor(search, "xterm")
-- helpers.add_hover_cursor(cute_battery_face, "hand1")


-- Create the sidebar
sidebar = wibox({visible = false, ontop = true, type = "dock", screen = 1 and 2})
sidebar.bg = beautiful.bg_normal -- For anti aliasing
sidebar.fg = beautiful.sidebar_fg or beautiful.wibar_fg or "#FFFFFF"
sidebar.opacity = beautiful.sidebar_opacity or 1
sidebar.height = screen.primary.geometry.height 
sidebar.width = beautiful.sidebar_width or dpi(300)
sidebar.y = beautiful.sidebar_y or 0
local radius = beautiful.sidebar_border_radius or 0
if beautiful.sidebar_position == "right" then
    awful.placement.top_right(sidebar)
else
    awful.placement.top_left(sidebar)
end
awful.placement.maximize_vertically(sidebar, { honor_workarea = true, margins = { top = dpi(1) ,bottom = dpi(33)} })

sidebar:buttons(gears.table.join(
    -- Middle click - Hide sidebar
    awful.button({ }, 2, function ()
        sidebar_hide()
    end)
))

sidebar_show = function()
    sidebar.visible = true
end

sidebar_hide = function()
    -- Do not hide it if prompt is active
    if not prompt_is_active() then
        sidebar.visible = false
    end
end

sidebar_toggle = function()
    if sidebar.visible then
        sidebar_hide()
    else
        sidebar.visible = true
    end
end

-- Hide sidebar when mouse leaves
if user.sidebar.hide_on_mouse_leave then
    sidebar:connect_signal("mouse::leave", function ()
        sidebar_hide()
    end)
end

-- Item placement
sidebar:setup {
    {
        { ----------- TOP GROUP -----------
            {
                helpers.vertical_pad(dpi(45)),
                {
                    nil,
                    {
                        time,
                        spacing = dpi(12),
                        layout = wibox.layout.fixed.horizontal
                    },
                    expand = "none",
                    layout = wibox.layout.align.horizontal
                },
                helpers.vertical_pad(dpi(15)),
                day_of_the_week,
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.fixed.vertical
        },
        { ----------- MIDDLE GROUP -----------
            {
                helpers.vertical_pad(dpi(15)),
                nil,
                {
                    {
                        mpd_buttons,
                        mpd_song,
                        spacing = dpi(5),
                        layout = wibox.layout.fixed.vertical
                    },
                    top = dpi(40),
                    bottom = dpi(60),
                    left = dpi(20),
                    right = dpi(20),
                    widget = wibox.container.margin
                },
                {
                    nil,
                    {
                        ram_box,
                        cpu_box,
                        temperature_box,
                        battery_box,
                        brightness_box,
                        volume_box,
                        adaptive_tooltip,
                        spacing = dpi(20),
                        layout = wibox.layout.fixed.vertical
                        -- layout = wibox.layout.fixed.horizontal
                    },
                    expand = "none",
                    layout = wibox.layout.align.horizontal,
                    helpers.vertical_pad(dpi(15)),
                    {
                        nil,
                        adaptive_tooltip,
                        expand = "none",
                        layout = wibox.layout.fixed.horizontal,
                    },

                },
                helpers.vertical_pad(dpi(30)),
                layout = wibox.layout.fixed.vertical
            },
            shape = helpers.prrect(beautiful.sidebar_border_radius, false, true, false, false),
            bg = x.color0.."66",
            widget = wibox.container.background
        },
        { ----------- BOTTOM GROUP -----------
            {
                {
                    {
                        nil,
                        bookmarks,
                        helpers.vertical_pad(dpi(15)),
                        urls,
                        spacing = dpi(20),
                        expand = "none",
                        layout = wibox.layout.fixed.vertical,
                    },
                    helpers.vertical_pad(dpi(30)),
                    {
                        nil,
                        close,
                        expand = "none",
                        layout = wibox.layout.align.horizontal,
                    },
                    layout = wibox.layout.align.vertical
                },
                left = dpi(20),
                right = dpi(20),
                bottom = dpi(45),
                widget = wibox.container.margin
            },
            bg = x.color0.."66",
            widget = wibox.container.background
        },
        layout = wibox.layout.align.vertical,
    },
    shape = helpers.prrect(beautiful.sidebar_border_radius, false, true, false, false),
    bg = beautiful.bg_normal or beautiful.wibar_bg or "#111111",
    widget = wibox.container.background
}
