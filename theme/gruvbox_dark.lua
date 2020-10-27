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
-- Wallpaper
-- ===================================================================
theme.wallpaper = gears.filesystem.get_configuration_dir() ..  "wallpaper/linux_dark.png"

-- Font
theme.font       = "Input Mono Narrow 9"
theme.title_font = "Cookie Bold 10"
theme.title_fg   = "#FFF"

-- Background
theme.bg_normal   = "#282828"
theme.bg_dim      = "#1d2021"
theme.bg_dark     = "#282828"
theme.bg_focus    = "#3c3836"
theme.bg_urgent   = "#d8a657"
theme.bg_minimize = "#fbf1c7"
theme.bg_systray  = theme.bg_normal
theme.bg_bar      = "#1d2021"

-- Foreground
theme.fg_normal   = "#d4be98"
theme.fg_focus    = "#d4be98"
theme.fg_urgent   = "#d4be98"
theme.fg_minimize = "#d4be98"

-- 16 Colors
-- Normal
theme.black   = "#282828"
theme.red     = "#ea6962" 
theme.green   = "#a9b665" 
theme.blue    = "#d8a657" 
theme.yellow  = "#7daea3" 
theme.magenta = "#d3869b"
theme.cyan    = "#89b482"
theme.white   = "#d4be98" 

-- Bright
theme.brightBlack   = "#282828"
theme.brightRed     = "#ea6962"
theme.brightGreen   = "#a9b665"
theme.brightYellow  = "#d8a657"
theme.brightBlue    = "#7daea3"
theme.brightMagenta = "#d3869b"
theme.brightCyan    = "#89b482"
theme.brightWhite   = "#d4be98"

-- Window Gap Distance
theme.useless_gap = dpi(10)
theme.screen_margin = dpi(12)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width  = dpi(5)
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.green 
theme.border_marked = theme.red
theme.border_radius = dpi(0)

-- Notification 
theme.notification_position = "top_right"
theme.notification_border_width = dpi(2)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = x.background
theme.notification_bg = theme.bg_normal
-- theme.notification_bg = x.color8
theme.notification_fg = x.color7
theme.notification_crit_bg = theme.bg_normal
theme.notification_crit_fg = theme.red
theme.notification_icon_size = dpi(60)
-- theme.notification_height = dpi(80)
-- theme.notification_width = dpi(300)
theme.notification_margin = dpi(16)
theme.notification_opacity = 0.8
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

-- ===================================================================
-- Icons
-- ===================================================================

-- You can use your own layout icons like this:
theme.layout_tile = "~/.config/awesome/icons/layout/tile.png"
theme.layout_floating = "~/.config/awesome/icons/layout/float.png"
theme.layout_max = "~/.config/awesome/icons/layout/max.png"

theme.icon_theme = "~/.local/share/Reversal-blue"

-- return theme
return theme
