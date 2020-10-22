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
theme.title_font = "Cookie Bold 12"
theme.title_fg = "#FFF"

-- Background
theme.bg_normal = "#282c34"
theme.bg_dim = "#282c34"
theme.bg_dark = "#282c34"
theme.bg_focus = "#282c34"
theme.bg_urgent = "#FFFF00"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal
theme.bg_bar = "#3d434f"
theme.hover = "#00000000"

-- Foreground
theme.fg_normal = "#abb2bf"
theme.fg_focus = "#e4e4e4"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- 16 Colors
-- Normal
theme.black   = "#4a505d"
theme.red     = "#f81141" 
theme.green   = "#23974a" 
theme.yellow  = "#fd7e57" 
theme.blue    = "#285bff" 
theme.magenta = "#8c62fd"
theme.cyan    = "#366f9a"
theme.white   = "#ccd5e5" 

-- Bright
theme.brightBlack   = "#61697a"
theme.brightRed     = "#fc4a6d"
theme.brightGreen   = "#37bd58"
theme.brightYellow  = "#f6be48"
theme.brightBlue    = "#199ffd"
theme.brightMagenta = "#fc58f6"
theme.brightCyan    = "#50acae"
theme.brightWhite   = "#ffffff"

-- Window Gap Distance
theme.useless_gap = dpi(10)
theme.screen_margin = dpi(10)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(3)
theme.border_normal = theme.bg_normal
theme.border_focus = theme.blue 
theme.border_marked = theme.blue

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
theme.volume_bar_active_color = x.color1
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
