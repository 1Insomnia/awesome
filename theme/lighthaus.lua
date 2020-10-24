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
theme.wallpaper = gears.filesystem.get_configuration_dir() ..  "wallpaper/LightHouseNight.jpg"

-- Font
theme.font = "Input Mono Narrow 9"
theme.title_font = "Cookie Bold 10"
theme.title_fg = "#FFF"

-- Background
theme.bg_normal = "#18191E"
theme.bg_dim = "#18191E"
theme.bg_dark = "#18191E"
theme.bg_focus = "#18191E"
theme.bg_urgent = "#FFFF00"
theme.bg_minimize = "#21252D"
theme.bg_systray = theme.bg_normal
theme.bg_bar = "#18191E"
theme.hover = "#00000000"

-- Foreground
theme.fg_normal = "#FFEE79"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- 16 Colors
-- Normal

theme.black   = "#18191E"
theme.red     = "#FC2929" 
theme.green   = "#44B273" 
theme.yellow  = "#E25600" 
theme.blue    = "#1D918B" 
theme.magenta = "#D16BB7"
theme.cyan    = "#00BFA4"
theme.white   = "#CCCCCC" 

-- Bright
theme.brightBlack   = "#21252D"
theme.brightRed     = "#FF5050"
theme.brightGreen   = "#50C16E"
theme.brightYellow  = "#ED722E"
theme.brightBlue    = "#47A8A1"
theme.brightMagenta = "#D68EB2"
theme.brightCyan    = "#5AD1AA"
theme.brightWhite   = "#FFFADE"

-- Window Gap Distance
theme.useless_gap = dpi(10)
theme.screen_margin = dpi(12)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(2)
theme.border_normal = theme.bg_normal
theme.border_focus = theme.green 
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
