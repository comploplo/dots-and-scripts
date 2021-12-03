-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local lain = require("lain")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")

-- from https://github.com/streetturtle/awesome-wm-widgets
beautiful.tooltip_fg = beautiful.fg_normal
beautiful.tooltip_bg = beautiful.bg_normal
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
-- local volume_widget = require("awesome-wm-widgets.volume-widget.volume")

-- {{{ Error handling

if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors,
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then
      return
    end
    in_error = true
    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err),
    })
    in_error = false
  end)
end

-- }}}

-- {{{ Variable definitions

-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "xresources")
beautiful.init(theme_path)
beautiful.tasklist_disable_icon = true
beautiful.tasklist_align = "center"

-- This is used later as the default terminal and editor to run.
local terminal = "kitty"
-- local editor = os.getenv("EDITOR") or "nvim"
-- local editor_cmd = terminal .. " -e " .. editor
local browser = "firefox"

local ddterm = lain.util.quake({
  app = terminal,
  argname = "--name=%s",
  height = 0.35,
  width = 0.45,
  vert = "top",
  horiz = "right",
  border = 0,
  name = "termDD",
})

local ddbigterm = lain.util.quake({
  app = terminal,
  argname = "--name=%s",
  height = 0.85,
  width = 0.9,
  vert = "center",
  horiz = "center",
  border = 3,
  name = "bigtermDD",
})

local ddpavu = lain.util.quake({
  app = "pavucontrol",
  argname = "--name=%s",
  height = 0.6,
  width = 0.3,
  vert = "top",
  horiz = "left",
  border = 0,
  name = "pavuDD",
})

local ddsignal = lain.util.quake({
  app = "flatpak run org.signal.Signal",
  argname = "",
  name = "signal",
  height = 0.9,
  width = 0.5,
  vert = "center",
  horiz = "right",
  border = 0,
})

local dddiscord = lain.util.quake({
  app = "flatpak run com.discordapp.Discord",
  argname = "",
  name = "discord",
  height = 0.9,
  width = 0.5,
  vert = "center",
  horiz = "right",
  border = 0,
})

local ddqute = lain.util.quake({
  app = "qutebrowser music.youtube.com ",
  name = "music_browser",
  argname = "--config .config/qutebrowser/config.py --basedir .cache/scratchbrowser --qt-arg name music_browser",
  height = 1,
  width = 1,
  vert = "center",
  horiz = "left",
  border = 0,
})

-- local ddwal = lain.util.quake { app = terminal, argname = "--name=%s ~/.scripts/ranger-bg",
--                                 height = .4, width = .5, vert = "center",
--                                 horiz = "center", border = 3, name = "bgDD" }

-- local ddchat = lain.util.quake { app = "chatterino", argname = " ",
--                                  height = 1, width = .2, vert = "center",
--                                  horiz = "right", border = 3, name = "Chatterino 2.3.2 - comploplo" }

local modkey = "Mod4"
local shift = "Shift"
local ctrl = "Control"
-- local alt = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  -- awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.magnifier,
  lain.layout.centerwork,
  awful.layout.suit.max,
}

-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Keyboard map indicator and switcher
-- local mykeyboardlayout = awful.widget.keyboardlayout()

-- }}}

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

local function set_wallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

local function wibars_toggle()
  local s = awful.screen.focused()
  s.mywibox.visible = not s.mywibox.visible
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  set_wallpaper(s)
  -- each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
  -- create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- create an imagebox widget which will contain an icon indicating which layout we're using.
  -- we need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))
  -- create a taglist widget
  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  })

  -- create a tasklist widget
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  })

  -- create the wibox
  s.mywibox = awful.wibar({ position = "bottom", screen = s })

  -- add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- left widgets
      layout = wibox.layout.fixed.horizontal,
      -- mylauncher,
      s.mytaglist,
      wibox.widget.systray(),
      s.mypromptbox,
    },
    s.mytasklist, -- middle widget
    { -- right widgets
      -- volume_widget{ widget_type = 'vertical_bar' },
      layout = wibox.layout.fixed.horizontal,
      -- mykeyboardlayout,
      wibox.widget.textclock(),
      battery_widget(),
      s.mylayoutbox,
    },
  })
end)

-- }}}

-- {{{ Mouse bindings

root.buttons(gears.table.join(
  -- awful.button({ }, 3, function () mymainmenu:toggle() end),
  awful.button({}, 10, awful.tag.viewnext),
  awful.button({}, 11, awful.tag.viewprev)
))

-- }}}

-- {{{ Key bindings

local globalkeys = gears.table.join(
  awful.key({ modkey }, "`", hotkeys_popup.show_help, {}),
  awful.key({ modkey }, ",", awful.tag.viewprev, {}),
  awful.key({ modkey }, ".", awful.tag.viewnext, {}),
  awful.key({ modkey }, "/", awful.tag.history.restore, {}),
  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, {}),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, {}),
  -- awful.key({ modkey, }, "w", function () mymainmenu:show() end, { }),

  -- Layout manipulation
  awful.key({ modkey, shift }, "j", function()
    awful.client.swap.byidx(1)
  end, {}),
  awful.key({ modkey, shift }, "k", function()
    awful.client.swap.byidx(-1)
  end, {}),
  awful.key({ modkey, ctrl }, "j", function()
    awful.screen.focus_relative(1)
  end, {}),
  awful.key({ modkey, ctrl }, "k", function()
    awful.screen.focus_relative(-1)
  end, {}),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto, {}),
  awful.key({ modkey }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, {}),

  -- Standard program
  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, {}),
  -- awful.key({ modkey }, "\\", function () awful.spawn(terminal .. " -e ranger") end,      {  }),
  -- awful.key({ modkey, shift }, "s", function() awful.spawn("flatpak run org.signal.Signal") end, {}),
  -- awful.key({ modkey, shift }, "d", function() awful.spawn("flatpak run com.discordapp.Discord") end, {}),
  awful.key({ modkey, shift }, "f", function()
    awful.spawn(browser)
  end, {}),
  awful.key({ modkey, shift }, "g", function()
    awful.spawn("steam -silent")
  end, {}),
  awful.key({ modkey, shift }, "v", function()
    awful.spawn("neovide")
  end, {}),
  awful.key({ modkey, shift, ctrl }, "b", function()
    awful.spawn("blueman-applet")
  end, {}),
  awful.key({ modkey, shift, ctrl }, "z", function()
    awful.spawn("flatpak run us.zoom.Zoom")
  end, {}),
  awful.key({ modkey, shift }, "t", function()
    awful.spawn("/home/gabe/.scripts/theme set best-dark")
  end, {}),
  awful.key({ modkey, shift, ctrl }, "t", function()
    awful.spawn("/home/gabe/.scripts/theme set best-light")
  end, {}),
  awful.key({}, "Print", function()
    awful.spawn("scrt")
  end, {}),
  awful.key({ shift }, "Print", function()
    awful.spawn("scrt-select")
  end, {}),
  awful.key({ modkey }, "z", function()
    ddbigterm:toggle()
  end, {}),
  awful.key({ modkey, shift }, "z", function()
    ddterm:toggle()
  end, {}),
  awful.key({ modkey, shift }, "p", function()
    ddpavu:toggle()
  end, {}),
  awful.key({ modkey }, "s", function()
    ddsignal:toggle()
  end, {}),
  awful.key({ modkey }, "d", function()
    dddiscord:toggle()
  end, {}),
  awful.key({ modkey }, "q", function()
    ddqute:toggle()
  end, {}),
  -- awful.key({ modkey }, "\\", function () ddwal:toggle() end, { }),
  -- awful.key({ modkey, shift }, "c", function () ddchat:toggle() end, { }),

  -- restart and quit
  awful.key({ modkey, shift }, "r", awesome.restart, {}),
  awful.key({ modkey, shift, ctrl }, "q", awesome.quit, {}),
  awful.key({ modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, {}),
  awful.key({ modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, {}),
  awful.key({ modkey, shift }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, {}),
  awful.key({ modkey, shift }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, {}),
  awful.key({ modkey, ctrl }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, {}),
  awful.key({ modkey, ctrl }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, {}),
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, {}),
  awful.key({ modkey, shift }, "space", function()
    awful.layout.inc(-1)
  end, {}),
  awful.key({ modkey }, "r", function()
    awful.screen.focused().mypromptbox:run()
  end, {}),
  awful.key({ modkey, ctrl }, "n", function()
    local c = awful.client.restore()
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, {}),

  -- Menubar
  awful.key({ modkey }, "b", function()
    wibars_toggle()
  end, {}),
  awful.key({ modkey }, "p", function()
    menubar.show()
  end, {}),
  awful.key({ modkey, shift, ctrl }, "b", function()
    awful.spawn("kitty --class=kitty-background -e asciiquarium")
  end, {}),
  -- awful.key({ }, 'XF86AudioRaiseVolume', function() volume_widget:inc() end, { }),
  -- awful.key({ }, 'XF86AudioLowerVolume', function() volume_widget:dec() end, { }),
  -- awful.key({ }, 'XF86AudioMute', function() volume_widget:toggle() end, { }),
  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn("pamixer -i 5 ; notify-send 'volume is '$(pamixer --get-volume )'%'")
  end, {}),
  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn("pamixer -d 5 ; notify-send 'volume is '$(pamixer --get-volume )'%'")
  end, {}),
  -- awful.key({ }, 'XF86AudioMute', function() volume_widget:toggle() end, { }),
  awful.key({}, "XF86MonBrightnessUp", function()
    awful.spawn("brightnessctl set +10%")
  end, {}),
  awful.key({}, "XF86MonBrightnessDown", function()
    awful.spawn("brightnessctl set 10%-")
  end, {})
)

Clientkeys = gears.table.join(
  -- On the fly useless gaps change
  awful.key({ modkey }, "=", function()
    lain.util.useless_gaps_resize(1)
  end, {}),
  awful.key({ modkey }, "-", function()
    lain.util.useless_gaps_resize(-1)
  end, {}),
  awful.key({ modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, {}),
  awful.key({ modkey }, "BackSpace", function(c)
    c:kill()
  end, {}),
  awful.key({ modkey, shift }, "f", awful.client.floating.toggle, {}),
  awful.key({ modkey, ctrl }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, {}),
  awful.key({ modkey, shift }, "o", function(c)
    c:move_to_screen()
  end, {}),
  awful.key({ modkey, shift }, "t", function(c)
    c.ontop = not c.ontop
  end, {}),
  awful.key({ modkey }, "n", function(c)
    c.minimized = true
  end, {}),
  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, {}),
  awful.key({ modkey, ctrl }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end, {}),
  awful.key({ modkey, shift }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end, {})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(
    globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, {
      description = "view tag #" .. i,
      group = "tag",
    }),
    -- Toggle tag display.
    awful.key({ modkey, ctrl }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, {
      description = "toggle tag #" .. i,
      group = "tag",
    }),
    -- Move client to tag.
    awful.key({ modkey, shift }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, {
      description = "move focused client to tag #" .. i,
      group = "tag",
    }),
    -- Toggle tag on focused client.
    awful.key({ modkey, ctrl, shift }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, {
      description = "toggle focused client on tag #" .. i,
      group = "tag",
    })
  )
end

local clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Rules

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_color = beautiful.border_normal,
      border_width = beautiful.border_width,
      buttons = clientbuttons,
      focus = awful.client.focus.filter,
      keys = Clientkeys,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      raise = true,
      screen = awful.screen.preferred,
    },
  },
  { rule_any = { class = { "Firefox", "qutebrowser" } }, properties = { floating = false, opacity = 1 } },
  { rule_any = { class = { "chatterino" } }, properties = { floating = true } },
  { rule_any = { class = { "zoom" }, name = { "chat" } }, properties = { floating = true, ontop = true } },
  { rule_any = { class = { "zoom", "Praat" } }, properties = { floating = true } },
  { rule_any = { name = { "OpenGL*" } }, properties = { floating = true, ontop = true } },
  { rule_any = { name = { "Picture-in-picture" } }, properties = { floating = true, ontop = true } },
  {
    rule_any = { class = { "kitty-background" } },
    properties = {
      below = true,
      border_width = 0,
      floating = true,
      focus = false,
      maximized = true,
      opacity = 1,
      skip_taskbar = true,
      sticky = true,
      tag = "9",
    },
  },
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c):setup({
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Middle
      { -- Title
        align = "left",
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  })
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)

-- }}}
