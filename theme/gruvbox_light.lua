
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
theme.wallpaper = gears.filesystem.get_configuration_dir() ..  "wallpaper/linux_bright.png"

-- Font
theme.font       = "Input Mono Narrow 9"
theme.title_font = "Cookie Bold 10"
theme.title_fg   = "#FFF"

-- Background
theme.bg_normal   = "#fbf1c7"
theme.bg_dim      = "#f9f5d7"
theme.bg_dark     = "#fbf1c7"
theme.bg_focus    = "#e5d5ad"
theme.bg_urgent   = "#FFFF00"
theme.bg_minimize = "#fbf1c7"
theme.bg_systray  = theme.bg_normal
theme.bg_bar      = "#fbf1c7"

-- Foreground
theme.fg_normal   = "#654735"
theme.fg_focus    = "#654735"
theme.fg_urgent   = "#514036"
theme.fg_minimize = "#514036"

-- 16 Colors
-- Normal
theme.black   = "#654735"
theme.red     = "#c14a4a" 
theme.green   = "#6c782e" 
theme.blue    = "#45707a" 
theme.yellow  = "#b47109" 
theme.magenta = "#945e80"
theme.cyan    = "#4c7a5d"
theme.white   = "#928374" 

-- Bright
theme.brightBlack   = "#654735"
theme.brightRed     = "#c14a4a"
theme.brightGreen   = "#6c782e"
theme.brightYellow  = "#b47109"
theme.brightBlue    = "#45707a"
theme.brightMagenta = "#945e80"
theme.brightCyan    = "#4c7a5d"
theme.brightWhite   = "#928374"

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
