--      ████████╗ █████╗  ██████╗ ███████╗
--      ╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝
--         ██║   ███████║██║  ███╗███████╗
--         ██║   ██╔══██║██║   ██║╚════██║
--         ██║   ██║  ██║╚██████╔╝███████║
--         ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝

-- ===================================================================
-- Imports
-- ===================================================================


local dir = os.getenv("HOME") .. "/.config/awesome/icons/tags/"
local awful = require("awful")


-- ===================================================================
-- Define tags
-- ===================================================================


-- define module table
local tags = {
   {
      icon = dir .. "terminal.png",
      type = 'terminal',
      default_app = "kitty",
      screen = 1
   },
   {
      icon = dir .. "firefox.png",
      type = 'browser',
      default_app = 'firefox',
      screen = 1
   },
   {
      icon = dir .. "code.png",
      type = 'code',
      default_app = 'subl',
      screen = 1
   },
   {
      icon = dir .. "folder.png",
	  	type = 'files',
	  	default_app = 'thunar',
	  	screen = 1
   },
   {
      icon = dir .. "circle.png",
   },
   {
      icon = dir .. "floating.png",
   },
   -- {
   --    icon = dir .. "videogame.png",
   -- },
   -- {
   --    icon = dir .. "star.png",
   -- },
   -- {
   --    icon = dir .. "mail.png",
   -- },
   {
      icon = dir .. "spotify.png",
   }
}
return tags
