--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Import theme
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Import Keybinds
local keys = require("config.keys")
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

-- Import rules
local create_rules = require("config.rules").create
awful.rules.rules = create_rules(keys.clientkeys, keys.clientbuttons)

-- Import notification appearance
require("components.notifications")

-- Import components
require("components.exit-screen")
-- Autostart specified apps
local apps = require("config.apps")
apps.autostart()

local helpers = require("helpers")
local volume = require("components.volume")

-- ===================================================================
-- Set Up Screen & Connect Signals
-- ===================================================================

-- Define tag layouts
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.floating,
   awful.layout.suit.max,
}

user = {
    -- >> Default applications <<
    -- Check apps.lua for more
    terminal = "kitty -1",
    floating_terminal = "kitty -1",
    browser = "firefox",
    file_manager = "thunar",
    editor = "kitty -1 --class editor -e nvim",
    email_client = "thunderbird",
    music_client = "kitty -o font_size=12 --class music -e ncmpcpp",

    -- >> Web Search <<
    web_search_cmd = "xdg-open https://duckduckgo.com/?q=",
    -- web_search_cmd = "xdg-open https://www.google.com/search?q=",

    -- >> User profile <<
    profile_picture = os.getenv("HOME").."/.config/awesome/profile.png",

    -- Directories with fallback values
    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        music = os.getenv("XDG_MUSIC_DIR") or "~/Music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
        videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
        -- Make sure the directory exists so that your screenshots
        -- are not lost
        screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Pictures/Screenshots",
    },

    -- >> Sidebar <<
    sidebar = {
        hide_on_mouse_leave = true,
        show_on_mouse_screen_edge = true,
    },

    -- >> Lock screen <<
    -- This password will ONLY be used if you have not installed
    -- https://github.com/RMTT/lua-pam
    -- as described in the README instructions
    -- Leave it empty in order to unlock with just the Enter key.
    -- lock_screen_custom_password = "",
    lock_screen_custom_password = "awesome",

    -- >> Battery <<
    -- You will receive notifications when your battery reaches these
    -- levels.
    battery_threshold_low = 20,
    battery_threshold_critical = 5,
   -- >> Coronavirus <<
    -- Country to check for corona statistics
    -- Uses the https://corona-stats.online API
    coronavirus_country = "germany",
}

-- Import tag settings
local tags = require("config.tags")

-- Import panels
local bar = require("components.bar")

-- Set up each screen (add tags & panels)
awful.screen.connect_for_each_screen(function(s)
   for i, tag in pairs(tags) do
      awful.tag.add(i, {
         layout = awful.layout.suit.tile,
         screen = s,
         selected = i == 1
      })
   end
  -- Add the top panel to every screen
  bar.create(s)
end)

-- remove gaps if layout is set to max
tag.connect_signal('property::layout', function(t)
   local current_layout = awful.tag.getproperty(t, 'layout')
   if (current_layout == awful.layout.suit.max) then
      t.gap = 0
   else
      t.gap = beautiful.useless_gap
   end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
   -- Set the window as a slave (put it at the end of others instead of setting it as master)
   if not awesome.startup then
      awful.client.setslave(c)
   end

   if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
   end
end)

-- ===================================================================
-- Client Focusing
-- ===================================================================


-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")

-- Focus clients under mouse
client.connect_signal("mouse::enter", function(c)
   c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- ░█░█░█▀█░█░░░█░░░█▀█░█▀█░█▀█░█▀▀░█▀▄
-- ░█▄█░█▀█░█░░░█░░░█▀▀░█▀█░█▀▀░█▀▀░█▀▄
-- ░▀░▀░▀░▀░▀▀▀░▀▀▀░▀░░░▀░▀░▀░░░▀▀▀░▀░▀

-- ===================================================================
-- Garbage collection (allows for lower memory consumption)
-- ===================================================================

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
