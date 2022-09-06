-- ███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
-- ██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                                         

-- =========================================================
-- ======================= IMPORTS =========================
-- =========================================================

local naughty = require("naughty")
local menubar = require("menubar")
local ruled = require("ruled")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Helpers
local helpers = require("global.helpers")

-- =========================================================
-- ================== Theme Definitions ====================
-- =========================================================

naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(60)
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 6
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = dpi(24)
naughty.config.defaults.border_width = dpi(2)
naughty.config.defaults.position = "top_right"
naughty.config.defaults.shape = helpers.rrect(dpi(12))
naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(8)
naughty.config.icon_dirs = {
   "/usr/share/icons/Papirus",
   "/usr/share/icons/hicolor/",
   "/usr/share/pixmaps/"
}
naughty.config.icon_formats = {"svg", "png", "jpg", "gif"}

-- =========================================================
-- Rules
-- =========================================================

naughty.config.presets.low.timeout = 4
naughty.config.presets.critical.timeout = 0

naughty.config.presets.normal = {
   font = beautiful.title_fonts,
   fg = beautiful.fg_normal,
   bg = beautiful.bg_normal,
   position = "top_right"
}

naughty.config.presets.low = {
   font = beautiful.title_fonts,
   fg = beautiful.fg_normal,
   bg = beautiful.bg_normal,
   position = "top_right"
}

naughty.config.presets.critical = {
   font = beautiful.title_fonts,
   fg = beautiful.fg_critical,
   bg = beautiful.bg_critical,
   position = "top_right",
   timeout = 0
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical

-- ===================================================================
-- Error Handling
-- ===================================================================

naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		app_name = "Awesome",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
	})
end)
