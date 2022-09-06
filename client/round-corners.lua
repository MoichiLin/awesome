local beautiful = require("beautiful")
local helpers = require("global.helpers")
local gears = require("gears")

local roundcorners = {}

function roundcorners.enable()
    if beautiful.corner_radius and beautiful.corner_radius > 0 then
        client.connect_signal("manage", function(c, startup)
			if not c.fullscreen and not c.maximized then
				c.shape = helpers.rect(beautiful.corner_radius)
			end
		end)

        --- Fullscreen and maximized clients should not have rounded corners
		local function clientCallback(c)
			if c.fullscreen or c.maximized then
				c.shape = gears.shape.rectangle
			else
				c.shape = helpers.rrect(beautiful.corner_radius)
			end
		end

        client.connect_signal("property::fullscreen", clientCallback)
		client.connect_signal("property::maximized", clientCallback)

        beautiful.snap_shape = helpers.rrect(beautiful.corner_radius * 2)
	else
		beautiful.snap_shape = gears.shape.rectangle
    end
end

return roundcorners