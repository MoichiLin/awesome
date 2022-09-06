local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("global.helpers")
local mat_icon = require("widget.icon-button.icon")
local icons = require("icons.flaticons")
local widget_dir = os.getenv("HOME") .. "/.cache/awesome/"

local stringtoboolean = { ["true"] = true, ["false"] = false }
local headphone_state

local update_headphone_state = function()
	headphone_state = stringtoboolean[helpers.first_line(widget_dir .. "headphone_state")]
end
update_headphone_state()

local widget = wibox.widget {
	widget,
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, dpi(12))
	end,
	widget = wibox.container.background,
	bg = beautiful.toggle_button_inactive
}
helpers.add_hover_cursor(widget, "hand1")

local update_widget = function()
	if headphone_state then
		widget.widget = mat_icon(icons.headphone, dpi(22))
	else
		widget.widget = mat_icon(icons.volume, dpi(22))
	end
end
update_widget()

local power_on_cmd = [[
    pactl set-sink-port 0 analog-output-headphones
	echo "true" > ]] .. widget_dir .. [[headphone_state
	# Create an AwesomeWM Notification
	awesome-client "
	naughty = require('naughty')
	naughty.notification({
		app_name = 'Sound Manager',
		title = 'System Notification',
		message = 'Audio output set to Headphones',
		icon = ']] .. icons.headphone .. [['
	})
	"
]]

local power_off_cmd = [[
    pactl set-sink-port 0 analog-output-lineout
	echo "false" > ]] .. widget_dir .. [[headphone_state
	# Create an AwesomeWM Notification
	awesome-client "
	naughty = require('naughty')
	naughty.notification({
		app_name = 'Sound Manager',
		title = 'System Notification',
		message = 'Audio output set to Speakers',
		icon = ']] .. icons.volume .. [['
	})
	"
]]

local toggle_action = function()
	if headphone_state then
		awful.spawn.easy_async_with_shell(power_off_cmd, function()
			update_headphone_state()
			update_widget()
		end)
	else
		awful.spawn.easy_async_with_shell(power_on_cmd, function()
			update_headphone_state()
			update_widget()
		end)
	end
end

widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
	toggle_action()
end)))

return widget
