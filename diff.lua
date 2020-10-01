diff --git a/components/top-panel.lua b/components/top-panel.lua
index e9dfaf8..52406c9 100644
--- a/components/top-panel.lua
+++ b/components/top-panel.lua
@@ -24,18 +24,20 @@ local volume = require("components.volume")
 
 -- import widgets
 local task_list = require("widgets.task-list")
-local tag_list = require("widgets.tag-list")
+-- local tag_list = require("widgets.tag-list")
 local calendar = require("widgets.calendar")
 local network = require("widgets.network")()
 local battery = require("widgets.battery")
 local bluetooth = require("widgets.bluetooth")
 local layout_box = require("widgets.layout-box")
+local updater = require("widgets.package-updater")()
 
--- Bar color
+-- Bars Colors
 local ram_bar_color = beautiful.red
 local volume_bar_color = beautiful.green
 local battery_bar_color = beautiful.blue
--- define module table
+
+-- Function that creates a widget bar
 local function rounded_bar(color)
     return wibox.widget {
         max_value     = 100,
@@ -56,6 +58,7 @@ local function rounded_bar(color)
         widget        = wibox.widget.progressbar,
     }
 end
+
 -- Helper function that creates a button widget
 local create_button = function (symbol, color, bg_color, hover_color)
     local widget = wibox.widget {
@@ -87,7 +90,7 @@ local create_button = function (symbol, color, bg_color, hover_color)
     return section
 end
 
--- Logout button
+-- Logout widget button
 local exit = create_button("", beautiful.red, beautiful.bg_normal .."C0", beautiful.white .."E0")
 exit:buttons(gears.table.join(
     awful.button({ }, 1, function ()
@@ -95,7 +98,7 @@ exit:buttons(gears.table.join(
     end)
 ))
 
--- Music
+-- Music widget button (using mpd)
 local music = create_button("", beautiful.green, beautiful.bg_normal.."90", beautiful.white.."B0")
 
 music:buttons(gears.table.join(
@@ -181,7 +184,7 @@ top_panel.create = function(s)
       layout = wibox.layout.align.horizontal,
       {
          layout = wibox.layout.fixed.horizontal,
-         tag_list.create(s),
+         -- tag_list.create(s),
          task_list.create(s),
       },
       calendar,
@@ -193,7 +196,7 @@ top_panel.create = function(s)
          volume_bar,
          music,
          exit,
-         bluetooth,
+         updater,
          network,
          battery,
          layout_box,
diff --git a/config/apps.lua b/config/apps.lua
index 24430e7..b8b9386 100644
--- a/config/apps.lua
+++ b/config/apps.lua
@@ -30,7 +30,8 @@ apps.default = {
    lock = "i3lock",
    music = "kitty -o font_size=12 --class music -e ncmpcpp",
    screenshot = "scrot -e 'mv $f ~/Pictures/ 2>/dev/null'",
-   filebrowser = "thunar"
+   filebrowser = "thunar",
+	 package_manager = 'pamac-manager',
 }
 
 -- List of apps to start once on start-up
diff --git a/rc.lua b/rc.lua
index 60e1592..8f606c5 100644
--- a/rc.lua
+++ b/rc.lua
@@ -1,13 +1,10 @@
---       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
---      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
---      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
---      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
---      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
---      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
-
--- ===================================================================
--- Initialization
--- ===================================================================
+-- ░█▀█░█░█░█▀▀░█▀▀░█▀█░█▄█░█▀▀
+-- ░█▀█░█▄█░█▀▀░▀▀█░█░█░█░█░█▀▀
+-- ░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
+--
+-- ░▀█▀░█▀█░▀█▀░▀█▀░▀█▀░█▀█░█░░░▀█▀░▀▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█
+-- ░░█░░█░█░░█░░░█░░░█░░█▀█░█░░░░█░░▄▀░░█▀█░░█░░░█░░█░█░█░█
+-- ░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀
 
 -- Standard awesome library
 local gears = require("gears")
@@ -57,18 +54,10 @@ local tags = require("config.tags")
 
 -- Import panels
 local top_panel = require("components.top-panel")
+require("components.tag-bar")
 
 -- Set up each screen (add tags & panels)
 awful.screen.connect_for_each_screen(function(s)
-   for i, tag in pairs(tags) do
-      awful.tag.add(i, {
-         icon = tag.icon,
-         icon_only = true,
-         layout = awful.layout.suit.tile,
-         screen = s,
-         selected = i == 1
-      })
-   end
   -- Add the top panel to every screen
    top_panel.create(s)
 end)
