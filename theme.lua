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
-- gears.wallpaper.tiled(gears.filesystem.get_configuration_dir() ..
                          -- "wallpaper/bg.png", nil, {x = 0, y = 597})
gears.wallpaper.tiled(gears.filesystem.get_configuration_dir() .. "wallpaper/onedark_triangle.png", nil)
-- Font
theme.font = "Rec Mono Casual 9"
theme.title_font = "Rec Mono Casual 10"

-- Background
theme.bg_normal = "#1e2127"
theme.bg_dim = "#5c6370"
theme.bg_dark = "#000000"
theme.bg_focus = "#151821"
theme.bg_urgent = "#ed8274"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal
theme.bg_bar = "#20262C"
theme.hover = "#00000000"

-- Foreground
theme.fg_normal = "#ffffff"
theme.fg_focus = "#e4e4e4"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- 16 Colors
-- Normal
theme.black   = "#1e2127"
theme.red     = "#e06c75" 
theme.green   = "#98c379" 
theme.yellow  = "#d19a66" 
theme.blue    = "#61afef" 
theme.magenta = "#c678dd"
theme.cyan    = "#56b6c2"
theme.white   = "#828791" 

-- Bright
theme.brightBlack   = "#5c6370"
theme.brightRed     = "#e06c75"
theme.brightGreen   = "#98c379"
theme.brightYellow  = "#d19a66"
theme.brightBlue    = "#61afef"
theme.brightMagenta = "#c678dd"
theme.brightCyan    = "#56b6c2"
theme.brightWhite   = "#e6efff"

-- Window Gap Distance
theme.useless_gap = dpi(10)
theme.screen_margin = dpi(12)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(10)
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


-- ===================================================================
-- Icons
-- ===================================================================


-- You can use your own layout icons like this:
theme.layout_tile = "~/.config/awesome/icons/layouts/view-quilt.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/view-float.png"
theme.layout_max = "~/.config/awesome/icons/layouts/arrow-expand-all.png"

theme.icon_theme = "~/.local/share/Tela-dark"

-- return theme
return theme
