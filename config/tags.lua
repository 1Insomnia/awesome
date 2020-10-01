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
      type = 'terminal',
      default_app = "kitty",
      screen = 1
   },
   {
      type = 'browser',
      default_app = 'firefox',
      screen = 1
   },
   {
      type = 'code',
      default_app = 'subl',
      screen = 1
   },
   {
	  	type = 'files',
	  	default_app = 'thunar',
	  	screen = 1
   },
   {
	  	type = 'mail',
	  	default_app = 'thunderbird',
	  	screen = 1
   },
   {
	  	type = 'music',
	  	default_app = 'kitty -o ncmpcpp',
	  	screen = 1
   },
   {
	  	type = 'social',
	  	default_app = 'discord',
	  	screen = 1
   },
   {
	  	type = 'misc',
	  	default_app = 'emacs',
	  	screen = 1
   },
   {
	  	type = 'any',
	  	default_app = 'thunar',
	  	screen = 1
   },
   -- {
	  	-- type = 'files',
	  	-- default_app = 'thunar',
	  	-- screen = 1
   -- }
}
return tags
