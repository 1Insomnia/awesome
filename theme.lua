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
theme.bg_normal = "#1f2430"
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

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(2)
theme.border_normal = theme.bg_normal
theme.border_focus = theme.white 
theme.border_marked = theme.fg_urgent

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

-- Panel Sizing
theme.left_panel_width = dpi(55)
theme.top_panel_height = dpi(26)

-- Notification Sizing
theme.notification_max_width = dpi(350)


-- ===================================================================
-- Icons
-- ===================================================================


-- You can use your own layout icons like this:
theme.layout_tile = "~/.config/awesome/icons/layouts/view-quilt.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/view-float.png"
theme.layout_max = "~/.config/awesome/icons/layouts/arrow-expand-all.png"

theme.icon_theme = "Tela-dark"

-- return theme
return theme
