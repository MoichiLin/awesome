-- ████████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ██╗███████╗██╗
-- ╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--    ██║   ██║   ██║██████╔╝    ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--    ██║   ██║   ██║██╔═══╝     ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--    ██║   ╚██████╔╝██║         ██║     ██║  ██║██║ ╚████║███████╗███████╗
--    ╚═╝    ╚═════╝ ╚═╝         ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- =========================================================
-- ======================= IMPORTS =========================
-- =========================================================

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local get_dpi = require("beautiful").xresources.get_dpi

--widgets
local TaskList = require("panels.top-panel.task-list")
local TagList = require("panels.top-panel.tag-list")
local mat_icon_button = require("widget.icon-button.icon-button")
local mat_icon = require("widget.icon-button.icon")
local mat_icon_button_rect = require("widget.icon-button.icon-button-rect")
local icons = require("icons.flaticons")
local helpers = require("global.helpers")
local weather = require("widget.weather.text_weather")

-- define module table
local top_panel = {}

-- =========================================================
-- ======================== SETUP ==========================
-- =========================================================

-- --------- Clock -----------
local textclock =
wibox.widget.textclock(
    '<span font="' ..
    beautiful.date_time_font ..
    '"color="' ..
    beautiful.date_time_color ..
    '">%a %b %d,</span><span font="' ..
    beautiful.title_fonts .. '" color="' .. beautiful.date_time_color .. '"> %H:%M</span>'
)
local cw = wibox.container.margin(textclock, dpi(12), dpi(12), dpi(8), dpi(8))

-- ------ Plus Button --------
--Rofi Launcher

--local rofi_command =
--"env /usr/bin/rofi -dpi " ..
--    get_dpi() ..
--    " -width " ..
--    dpi(400) ..
--    " -show drun -theme " ..
--    gears.filesystem.get_configuration_dir() .. "/configs/rofi/rofi-" .. beautiful.rofi_plus_sign .. ".rasi"
--local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))
--add_button:buttons(
--    gears.table.join(
--        awful.button(
--            {},
--            1,
--            nil,
--            function()
--                awful.spawn(
--                    rofi_command
                -- awful.screen.focused().selected_tag.defaultApp,
                -- {
                --     tag = _G.mouse.screen.selected_tag,
                --     placement = awful.placement.bottom_right
                -- }
--                )
--            end
--        )
--    )
--)

-- -- layoutBox Keybinds -----
local LayoutBox = function(s)
    local layoutBox = helpers.ccontainer(awful.widget.layoutbox(s))
    layoutBox.forced_width = beautiful.layoutbox_width
    layoutBox:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {},
                4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                5,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )
    return layoutBox
end

-- Systray
local systray = require("panels.top-panel.systray")

-- dashboard
local vol_icon = helpers.imaker(icons.volume, dpi(20), dpi(20))
local act_icon = helpers.imaker(icons.activity, dpi(20), dpi(20))
local network_icon = helpers.imaker(icons.wifi, dpi(20), dpi(20))
local dashboard = wibox.container.background(
    wibox.container.margin {
        helpers.horizontal_pad(dpi(10)),
        network_icon,
        vol_icon,
        act_icon,
        helpers.horizontal_pad(dpi(10)),
        spacing = dpi(8),
        layout = wibox.layout.fixed.horizontal,
    },
    beautiful.widget_bg_normal,
    helpers.rrect(dpi(6))
)
dashboard.shape_border_width = dpi(2)
dashboard.shape_clip = true
dashboard.shape_border_color = beautiful.accent_normal .. "60"
helpers.add_hover_cursor(dashboard, "hand1")
dashboard:connect_signal(
    "button::press",
    function(_, _, _, button)
        if button == 1 then
            awesome.emit_signal("dashboard::toggle", awful.screen.focused())
        end
    end
)
dashboard:connect_signal(
    "mouse::enter",
    function()
        dashboard.shape_border_color = beautiful.accent_normal .. "80"
    end
)
dashboard:connect_signal(
    "mouse::leave",
    function()
        dashboard.shape_border_color = beautiful.accent_normal .. "60"
    end
)
local di = wibox.container.margin(dashboard, dpi(0), dpi(0), dpi(6), dpi(6))

-- =========================================================
-- ======================= TOP BAR =========================
-- =========================================================

top_panel.create = function(s)
    -- local height = s.geometry.height
    local panel =
    wibox(
        {
            ontop = true,
            screen = s,
            type = 'dock',
            height = beautiful.wibar_height,
            width = s.geometry.width,
            x = s.geometry.x,
            y = s.geometry.y,
            stretch = false,
            bg = beautiful.bg_wibar,
            fg = beautiful.fg_normal
        }
    )

    panel:struts(
        {
            top = beautiful.wibar_height
        }
    )

    panel:setup {
        expand = "none",
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            wibox.container.margin(TaskList(s), dpi(3), dpi(3), dpi(0), dpi(3)),
            add_button
        },
        wibox.container.margin(TagList(s), dpi(2), dpi(2), dpi(2), dpi(2)),
        {
            layout = wibox.layout.fixed.horizontal,
            -- weather,
            systray,
            di,
            cw,
            wibox.container.margin(LayoutBox(s), dpi(4), dpi(4), dpi(7), dpi(7)),
        }
    }

    awesome.connect_signal("panel::toggle", function(scr)
        if scr == s then
            s.top_panel.visible = not s.top_panel.visible
        end
    end)

    return panel
end
return top_panel
