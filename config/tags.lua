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


-- ===================================================================
-- Define tags
-- ===================================================================


-- define module table
local tags = {
   {
      icon = dir .. "terminal.png",
   },
   {
      icon = dir .. "firefox.png",
   },
   {
      icon = dir .. "code.png",
   },
   {
      icon = dir .. "folder.png",
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
