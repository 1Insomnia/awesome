--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
--      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
--         ██║   ███████║█████╗  ██╔████╔██║█████╗
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require('gears')
-- define module table

local theme = {}

-- ===================================================================
-- Theme Variables
-- ===================================================================
gears.wallpaper.tiled(gears.filesystem.get_configuration_dir() ..
                          "wallpaper/bg.png", nil, {x = 0, y = 597})
-- gears.wallpaper.tiled(gears.filesystem.get_configuration_dir() .. "wallpaper/onedark_triangle.png", nil)
-- Font
theme.font = "Input Mono Narrow 9"
theme.title_font = "Input Mono Narrow 10"
theme.title_fg = "#FFF"

-- Background
theme.bg_normal = "#282828"
theme.bg_dim = "#282828"
theme.bg_dark = "#282828"
theme.bg_focus = "#282828"
theme.bg_urgent = "#FFFF00"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal
theme.bg_bar = "#282828"
theme.hover = "#00000000"

-- Foreground
theme.fg_normal = "#a9b1d6"
theme.fg_focus = "#e4e4e4"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- 16 Colors
-- Normal
theme.black   = "#282828"
theme.red     = "#cc241d" 
theme.green   = "#98971a" 
theme.yellow  = "#d79921" 
theme.blue    = "#458588" 
theme.magenta = "#b16286"
theme.cyan    = "#689d6a"
theme.white   = "#a89984" 

-- Bright
theme.brightBlack   = "#928374"
theme.brightRed     = "#fb4934"
theme.brightGreen   = "#b8bb26"
theme.brightYellow  = "#fabd2f"
theme.brightBlue    = "#83a598"
theme.brightMagenta = "#d3869b"
theme.brightCyan    = "#8ec07c"
theme.brightWhite   = "#ebdbb2"

-- Window Gap Distance
theme.useless_gap = dpi(10)
theme.screen_margin = dpi(12)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(5)
theme.border_normal = theme.bg_normal
theme.border_focus = theme.red 
theme.border_marked = theme.red

-- Notification 
theme.notification_position = "top_right"
theme.notification_border_width = dpi(0)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = x.color10
theme.notification_bg = x.background
-- theme.notification_bg = x.color8
theme.notification_fg = x.foreground
theme.notification_crit_bg = x.background
theme.notification_crit_fg = x.color1
theme.notification_icon_size = dpi(60)
-- theme.notification_height = dpi(80)
-- theme.notification_width = dpi(300)
theme.notification_margin = dpi(16)
-- theme.notification_opacity = 1
-- theme.notification_font = "sans 11"
-- theme.notification_padding = theme.screen_margin * 2
-- theme.notification_spacing = theme.screen_margin * 4


-- Taglist
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_occupied = "#ffffff1a"
theme.taglist_bg_urgent = "#e91e6399"
theme.taglist_bg_focus = theme.bg_focus

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_bg_urgent = theme.bg_urgent

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal

-- Notification Sizing
theme.notification_max_width = dpi(350)


-- Mpd song
theme.mpd_song_title_color = x.color7
theme.mpd_song_artist_color = x.color7
theme.mpd_song_paused_color = x.color8

-- Volume bar
theme.volume_bar_active_color = x.color5
theme.volume_bar_active_background_color = x.color0
theme.volume_bar_muted_color = x.color8
theme.volume_bar_muted_background_color = x.color0

-- Temperature bar
theme.temperature_bar_active_color = x.color1
theme.temperature_bar_background_color = x.color0

-- Battery bar
theme.battery_bar_active_color = x.color6
theme.battery_bar_background_color = x.color0

-- CPU bar
theme.cpu_bar_active_color = x.color2
theme.cpu_bar_background_color = x.color0

-- RAM bar
theme.ram_bar_active_color = x.color4
theme.ram_bar_background_color = x.color0

-- Brightness bar
theme.brightness_bar_active_color = x.color3
theme.brightness_bar_background_color = x.color0

-- ===================================================================
-- Icons
-- ===================================================================


-- You can use your own layout icons like this:
theme.layout_tile = "~/.config/awesome/icons/layout/tile.png"
theme.layout_floating = "~/.config/awesome/icons/layout/float.png"
theme.layout_max = "~/.config/awesome/icons/layout/max.png"

theme.icon_theme = "~/.local/share/Tela-dark"

-- return theme
return theme