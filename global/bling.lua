local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local gfs = gears.filesystem
local beautiful = require("beautiful")
local bling = require("submodules.bling")

-- ------- wallapper ---------

awful.screen.connect_for_each_screen(function(s)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper

		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end

		gears.wallpaper.maximized(wallpaper, s, false, nil)
	end
end)

-- -------- Taglist ----------

-- tag preview
bling.widget.tag_preview.enable {
  show_client_content = true,
  placement_fn = function(c)
    awful.placement.top(
      c,
      {
        margins = {
          top = beautiful.wibar_height + beautiful.useless_gap * 4
        }
      }
    )
  end,
  scale = 0.16,
  honor_padding = true,
  honor_workarea = true,
  background_widget = wibox.widget {
    -- Set a background image (like a wallpaper) for the widget
    image = beautiful.wallpaper,
    horizontal_fit_policy = "fit",
    vertical_fit_policy = "fit",
    widget = wibox.widget.imagebox
  }
}

-- ------ flash focus --------

-- bling.module.flash_focus.enable()

-- ------ scratchpad ---------

SCRATCHPAD = bling.module.scratchpad {
  command                 = "wezterm start --class music nvim ~/Documents/TextFile.txt", -- How to spawn the scratchpad
  rule                    = { instance = "music" }, -- The rule that the scratchpad will be searched by
  sticky                  = true, -- Whether the scratchpad should be sticky
  autoclose               = false, -- Whether it should hide itself when losing focus
  floating                = true, -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
  geometry                = { x = 1310, y = 45, height = 400, width = 600 }, -- The geometry in a floating state
  reapply                 = true, -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
  dont_focus_before_close = true, -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
}

