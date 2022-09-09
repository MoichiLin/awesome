--  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
-- ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
-- ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
-- ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
-- ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
--  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝

-- =========================================================
-- ======================= IMPORTS =========================
-- =========================================================

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

local helpers = require("global.helpers")

-- =========================================================
-- ================= USER CONFIGURATION ====================
-- =========================================================

-- color scheme
local color_scheme = {
    "nord", --1
    "gruvbox", --2
    "rxyhn", --3
}
local colors = color_scheme[3]

--Num lock
awful.spawn.once("numlockx on")

--Rofi Launcher
awful.spawn.easy_async_with_shell([[echo '@theme "rofi-]] ..
    colors .. [["' > ]] .. os.getenv("HOME") .. [[/.config/rofi/config.rasi]])
local rofi_command = "rofi -show drun"

-- Set lock theme
awful.spawn.easy_async_with_shell([[cat ~/.config/awesome/configs/lock-]] ..
    colors .. [[ > ]] .. gears.filesystem.get_configuration_dir() .. [[configs/lock]])

-- Default apps global variable
apps = {
    editor = "kate",
    terminal = "kitty",
    launcher = rofi_command,
    lock = gears.filesystem.get_configuration_dir() .. "configs/lock-" .. colors,
    screenshot = "flameshot gui",
    filebrowser = "thunar",
    browser = "google-chrome-stable",
    taskmanager = "gnome-system-monitor",
    soundctrlpanel = "pavucontrol"
}

-- define wireless and ethernet interface names for the network widget
-- use `ip link` command to determine these
-- NETWORK = {
--     wlan = "wlp1s0",
--     lan = "enp4s0"
-- }

--OpenWeatherMap
WEATHER = {
    key = "",
    city_id = "",
    units = "metric"
}

-- Startup apps
--- picom
helpers.check_if_running(
    "picom",
    nil,
    function()
        awful.spawn("picom --experimental-backends --config " ..
            gears.filesystem.get_configuration_dir() .. "configs/picom.conf", false)
    end
)
helpers.run_once_pgrep("fcitx5")
--- Polkit Agent
helpers.run_once_ps(
    "polkit-gnome-authentication-agent-1",
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
)
--- Other stuff
helpers.run_once_pgrep("blueman-applet")
helpers.run_once_pgrep("nm-applet --indicator")
helpers.run_once_pgrep(gears.filesystem.get_configuration_dir() .. "configs/nvidia-startup")
-- 
awful.spawn.easy_async_with_shell([[echo "  & sleep 5 && xset dpms force off" >> ]] .. gears.filesystem.get_configuration_dir() .. [[configs/lock]])
helpers.check_if_running(
    "xidlehook",
    nil,
    function()
        helpers.run_once_pgrep(gears.filesystem.get_configuration_dir() .. "configs/xidlehook")
    end
)

-- =========================================================
-- =================== DEFINE LAYOUTS ======================
-- =========================================================

-- https://awesomewm.org/doc/api/libraries/awful.layout.html#Client_layouts
-- set icons in the theme file

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.spiral.dwindle,
}

-- =========================================================
-- ======================== SETUP ==========================
-- =========================================================

-- ----- Import theme --------
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/" .. colors .. "_pallete.lua")

-- ----- modules -------
require("global.bling")
require("submodules.better-resize")

-- ----- round corners -------
-- require("client.round-corners").enable()

-- ----- import panel --------
require("panels")

--- ------ Import Tags --------
require("panels.tags")

-- Titlebars on clients
-- require("client.titlebar")

-- - Import notifications ----
require("global.notification")

-- Import Keybinds
local keys = require("global.keys")
root.keys(keys.globalkeys)
root.buttons(keys.globalbuttons)

-- Import rules
local create_rules = require("client.rules").create
awful.rules.rules = create_rules(keys.clientkeys, keys.clientbuttons)

-- import widgets
require("widget.volume-slider.volume-osd")
require("widget.weather.weather_main")
require("widget.brightness-slider.brightness-osd")
require("global.exit-screen")

-- Signal function to execute when a new client appears.
client.connect_signal(
    "manage",
    function(c)
        -- Set the window as a slave (put it at the end of others instead of setting it as master)
        if not awesome.startup then
            awful.client.setslave(c)
        end

        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end
)

-- Make the focused window have a glowing border
client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_accent
    end
)
client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.bg_normal
    end
)

-- =========================================================
-- =================== CLIENT FOCUSING =====================
-- =========================================================

-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")

-- Focus clients under mouse
-- client.connect_signal(
--     "mouse::enter",
--     function(c)
--         c:emit_signal("request::activate", "mouse_enter", { raise = false })
--     end
-- )

-- =========================================================
--  Garbage collection (allows for lower memory consumption) =
-- =========================================================

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
