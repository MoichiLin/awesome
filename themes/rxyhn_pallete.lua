-- ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
-- ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
--    ██║   ███████║█████╗  ██╔████╔██║█████╗
--    ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
--    ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
--    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

-- =========================================================
-- ======================= Import ==========================
-- =========================================================

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("global.helpers")
local gears = require("gears")
local gfs = require("gears.filesystem")
local icons = require("icons.flaticons")
local awful = require("awful")

-- define module table
local theme = {}

-- =========================================================
-- ======================= Pallete =========================
-- =========================================================

--- Special
theme.xforeground = "#D9D7D6"
theme.darker_xbackground = "#000a0e"
theme.xbackground = "#061115"
theme.lighter_xbackground = "#0d181c"
theme.one_bg = "#131e22"
theme.one_bg2 = "#1c272b"
theme.one_bg3 = "#242f33"
theme.grey = "#313c40"
theme.grey_fg = "#3b464a"
theme.grey_fg2 = "#455054"
theme.light_grey = "#4f5a5e"
theme.transparent = "#00000000"

--- Black
theme.xcolor0 = "#1C252C"
theme.xcolor8 = "#484E5B"

--- Red
theme.xcolor1 = "#DF5B61"
theme.xcolor9 = "#F16269"

--- Green
theme.xcolor2 = "#78B892"
theme.xcolor10 = "#8CD7AA"

--- Yellow
theme.xcolor3 = "#DE8F78"
theme.xcolor11 = "#E9967E"

--- Blue
theme.xcolor4 = "#6791C9"
theme.xcolor12 = "#79AAEB"

--- Magenta
theme.xcolor5 = "#BC83E3"
theme.xcolor13 = "#C488EC"

--- Cyan
theme.xcolor6 = "#67AFC1"
theme.xcolor14 = "#7ACFE4"

--- White
theme.xcolor7 = "#D9D7D6"
theme.xcolor15 = "#E5E5E5"

-- =========================================================
-- =================== THEME VARIABLES =====================
-- =========================================================

function theme.random_accent_color()
    local accents = {
        theme.xcolor9,
        theme.xcolor10,
        theme.xcolor11,
        theme.xcolor12,
        theme.xcolor13,
        theme.xcolor14,
    }

    local i = math.random(1, #accents)
    return accents[i]
end

-- =========================================================
--  Script to change svg color (run this when changing theme)
-- =========================================================

local icon_colors = {
    nord = "#e5e9f0",
    gruvbox = "#EBDBB2",
    rxyhn = "#6791C9"
}
local icon_location1 = os.getenv("HOME") .. "/.config/awesome/icons/flaticons/"
local icon_location2 = os.getenv("HOME") .. "/.config/awesome/icons/places/"

awful.spawn.easy_async_with_shell(
    [[        
        for x in ]] .. icon_location1 .. [[*
        do
        sed -e "s/]] ..
    icon_colors.gruvbox ..
    [[/]] .. icon_colors.rxyhn .. [[/g;s/]] .. icon_colors.nord .. [[/]] .. icon_colors.rxyhn .. [[/g" $x > temp
        mv temp "$x"
        done

        for x in ]] .. icon_location2 .. [[*
        do
        sed -e "s/]] ..
    icon_colors.gruvbox ..
    [[/]] .. icon_colors.rxyhn .. [[/g;s/]] .. icon_colors.nord .. [[/]] .. icon_colors.rxyhn .. [[/g" $x > temp
        mv temp "$x"
        done
    ]]
)

-- ------- Wallpaper ---------
local directory = gfs.get_configuration_dir() .. "wallpapers/"
local wallpapers = {
    "garden-house.png",
    "wallpaper-dimmed.jpg",
    "wp8148965-minimalist-landscape-wallpapers.jpg",
    "mountains-landscape-sunrise-minimalist-minimalism-y7214.jpg"
}
theme.wallpaper = directory .. wallpapers[2]

-- --------- rofi ------------
theme.rofi_plus_sign = "nord"

-- ---- profile picture ------
theme.pfp = gears.surface.load_uncached(gears.filesystem.get_configuration_dir() .. "icons/user/profile.png")

-- --------- wibar -----------
theme.wibar_height = dpi(36)

-- --------- gaps ------------
theme.useless_gap = dpi(4)
theme.gap_single_client = true

-- --------- Fonts -----------
theme.title_fonts = "Roboto Bold 11"
theme.normal_fonts = "Roboto 11"
theme.date_time_font = "Roboto Bold 11"
theme.icon_fonts = "Material Icons Round"

-- -- clickable container ----
theme.mouse_enter = theme.xcolor14
theme.mouse_press = theme.xcolor6
theme.mouse_release = theme.xcolor14

-- -------- accent -----------
theme.accent_normal = theme.xcolor4

-- -------- accent titlebar -----------
theme.accent_normal_c = theme.xcolor1
theme.accent_normal_max = theme.xcolor3
theme.accent_normal_min = theme.xcolor2
theme.accent_normal_float = theme.xcolor5
theme.close_icon = icons.close
theme.maximize_icon = ""
theme.minimize_icon = "" 
theme.float_icon = "" 

-- ------ foreground ---------
theme.fg_normal = theme.xcolor15
theme.fg_critical = theme.xcolor9

-- ------ background ---------
theme.bg_normal = "#0B161A"
theme.bg_normal_alt = theme.lighter_xbackground
theme.bg_critical = theme.xcolor9

-- -------- client -----------
theme.titlebars_enabled = true
theme.titlebar_buttonsize_alt = dpi(18)
theme.titlebar_buttonsize = dpi(20)
theme.titlebar_size = dpi(25)
theme.titlebar_color = theme.xbackground
theme.border_width = dpi(1)
theme.border_accent = theme.xcolor4
-- round corners
theme.corner_radius = dpi(8)

-- -------- widgets ----------
theme.widget_box_radius = dpi(12)
theme.widget_box_gap = dpi(8)
theme.widget_margin_color = "#FF000000"
theme.widget_bg_normal = theme.xcolor0

-- ------- LayoutBox ---------
theme.layoutbox_width = dpi(24)

-- ------- dashboard ---------
theme.dashboard_min_height = dpi(600)
theme.dashboard_max_height = dpi(600)
theme.dashboard_max_width = dpi(600)
theme.dashboard_min_width = dpi(600)
theme.dashboard_margin = dpi(2)
theme.dashboard_margin_color = theme.xbackground

-- ------ System Tray --------
theme.systray_icon_spacing = dpi(8)

-- --------- Menu ------------
theme.menu_font = "Roboto 10"
theme.menu_height = dpi(24)
theme.menu_width = dpi(120)
theme.menu_border_color = theme.xbackground
theme.menu_border_width = dpi(2)
theme.menu_fg_focus = theme.xcolor4 .. "20"
theme.menu_bg_focus = theme.xcolor8
theme.menu_fg_normal = theme.xcolor15
theme.menu_bg_normal = theme.xcolor0

-- ------- TaskList ----------
theme.tasklist_font = "Roboto Mono Nerd Fonts Bold 10"
theme.tasklist_bg_normal = theme.xcolor0
theme.tasklist_bg_focus = theme.xcolor8 .. "4f"
theme.tasklist_bg_urgent = theme.xcolor0
theme.tasklist_fg_focus = theme.xcolor15
theme.tasklist_fg_urgent = theme.xcolor9
theme.tasklist_fg_normal = theme.xcolor7
-- theme.tasklist_disable_task_name = true
theme.tasklist_plain_task_name = true
theme.tasklist_shape = helpers.rect(dpi(4))

-- -------- Taglist ----------
theme.taglist_bg_empty    = theme.bg_normal
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_bg_urgent   = theme.bg_normal
theme.taglist_bg_focus    = theme.bg_normal
theme.taglist_font        = theme.title_fonts
theme.taglist_spacing     = 2
theme.taglist_fg_focus    = theme.xcolor15
theme.taglist_fg_occupied = theme.xcolor4
theme.taglist_fg_urgent   = theme.xcolor9
theme.taglist_fg_empty    = theme.xcolor8
theme.taglist_bg_focus    = theme.xcolor8
theme.taglist_shape       = helpers.rrect(dpi(6))

-- --- tag preview bling -----
theme.tag_preview_widget_border_radius = dpi(0) -- Border radius of the widget (With AA)
theme.tag_preview_client_border_radius = theme.border_width / 2 -- Border radius of each client in the widget (With AA)
theme.tag_preview_client_opacity = 1 -- Opacity of each client
theme.tag_preview_client_bg = theme.bg_normal -- The bg color of each client
theme.tag_preview_client_border_color = theme.xcolor4 -- The border color of each client
theme.tag_preview_client_border_width = dpi(1) -- The border width of each client
theme.tag_preview_widget_bg = theme.xcolor4 -- The bg color of the widget
theme.tag_preview_widget_border_color = theme.xcolor4 -- The border color of the widget
theme.tag_preview_widget_border_width = dpi(0) -- The border width of the widget
theme.tag_preview_widget_margin = dpi(0) -- The margin of the widget

-- ------- Snapping ----------
theme.snap_bg = theme.xcolor4
theme.snap_border_width = dpi(1)

-- ---- Toggle buttons -------
theme.toggle_button_inactive = theme.grey
theme.toggle_button_active = theme.xcolor4 .. "60"

-- --------- music -----------
theme.music = gears.surface.load_uncached(gears.filesystem.get_configuration_dir() .. "wallpapers/music.png")
theme.playerctl_ignore = "firefox"
theme.playerctl_player = { "music", "%any" }

-- ------- date/time ---------
theme.date_time_color = theme.xcolor4

-- ------- calender ----------
theme.cal_header_bg = theme.transparent
theme.cal_week_bg = theme.transparent
theme.cal_focus_bg = theme.accent_normal
theme.cal_header_fg = theme.accent_normal
theme.cal_focus_fg = theme.fg_normal
theme.cal_week_fg = theme.fg_normal

-- ----- Hotkey popup --------
theme.hotkeys_shape = helpers.rrect(dpi(12))
theme.hotkeys_border_width = dpi(1)
theme.hotkeys_font = "JetBrainsMono Nerd Font 12"
theme.hotkeys_group_margin = dpi(10)
theme.hotkeys_label_bg = theme.bg_normal
theme.hotkeys_label_fg = theme.bg_normal
theme.hotkeys_description_font = "JetBrains Mono Nerd Font 10"
theme.hotkeys_modifiers_fg = theme.fg_normal
theme.hotkeys_bg = theme.bg_normal

-- --- flash focus bling -----
theme.flash_focus_start_opacity = 0.7 -- the starting opacity
theme.flash_focus_step = 0.01 -- the step of animation

-- --------- Icons -----------

theme.layout_floating = icons.floating
theme.layout_max = icons.max
theme.layout_tile = icons.tile
theme.layout_dwindle = icons.dwindle
theme.layout_centered = icons.centered
theme.layout_mstab = icons.mstab
theme.layout_equalarea = icons.equalarea
theme.layout_machi = icons.machi

-- return theme
return theme
