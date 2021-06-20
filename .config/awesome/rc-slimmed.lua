pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local lain = require("lain")


-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "xresources")
beautiful.init(theme_path)
beautiful.tasklist_disable_icon = true
beautiful.tasklist_align = "center"

terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
browser = "firefox"
local ddterm = lain.util.quake { app = terminal, argname = "--name=%s", height = .35, width = .45, vert = "bottom", horiz = "right", border = 0, name = "termDD" }
local ddbigterm = lain.util.quake { app = terminal, argname = "--name=%s", height = .85, width = .9, vert = "center", horiz = "center", border = 3, name = "bigtermDD" }
local ddpavu = lain.util.quake { app = "pavucontrol", argname = "--name=%s", height = .6, width = .3, vert = "top", horiz = "left", border = 0, name = "pavuDD" }
local ddwal = lain.util.quake { app = terminal, argname = "--name=%s ~/.scripts/ranger-bg", height = .4, width = .5, vert = "center", horiz = "center", border = 3, name = "bgDD" }

alt = "Mod1"
shift = "Shift"
modkey = "Mod4"
control = "Control"

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.magnifier,
    lain.layout.centerwork,
    awful.layout.suit.max,
}


menubar.utils.terminal = terminal -- Set the terminal for applications that require it


-- }}}

-- {{{ Wibar

local mykeyboardlayout = awful.widget.keyboardlayout()
local mytextclock = wibox.widget.textclock()
local mybattery = batteryarc_widget()
local myvolume volume_widget{ widget_type = 'vertical_bar' }

local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then c.minimized = true else
            c:emit_signal(
              "request::activate",
              "tasklist",
              {raise = true}
            ) end end),
    awful.button({ }, 3, function()
        awful.menu.client_list({ theme = { width = 250 } }) end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1) end)
)

local function set_wallpaper(s)
    if beautiful.wallpaper then local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

local function wibars_toggle()
    local s = awful.screen.focused()
    s.mywibox.visible = not s.mywibox.visible
end


-- disabled experimentally for use with theme may 10
-- screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[1])
    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
            wibox.widget.systray(),
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            volume_widget{ widget_type = 'vertical_bar' },
            layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
            mytextclock,
            battery_widget(),
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    -- awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 10, awful.tag.viewnext),
    awful.button({ }, 11, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "`",      hotkeys_popup.show_help,                     {description="show help", group="awesome"}),
    awful.key({ modkey,           }, ",",   awful.tag.viewprev,                             {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, ".",  awful.tag.viewnext,                              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "/", awful.tag.history.restore,                        {description = "go back", group = "tag"}),
    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,     {description = "focus next by index", group = "client"}),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,     {description = "focus previous by index", group = "client"}),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              -- {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,  {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,  {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,  {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,  {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,                       {description = "jump to urgent client", group = "client"}),
    -- awful.key({ modkey,           }, "Tab",
    --     function ()
    --         awful.client.focus.history.previous()
    --         if client.focus then
    --             client.focus:raise()
    --         end
    --     end,                                                                                {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,          }, "Return", function () awful.spawn(terminal) end,        {description = "open a terminal", group = "launcher"}),
    -- awful.key({ modkey }, "\\", function () awful.spawn(terminal .. " -e ranger") end,      {description = "open a terminal file manager", group = "launcher"}),
    awful.key({ modkey, "Shift"  }, "b", function () awful.spawn(browser) end,              {description = "Open a browser", group = "launcher"}),
    awful.key({ modkey, "Shift"  }, "s", function () awful.spawn("signal-desktop")  end,    {description = "Open signal", group = "launcher"}),
    awful.key({ modkey, "Shift"  }, "d", 
        function () awful.spawn("flatpak run com.discordapp.Discord") end,                  {description = "Open discord", group = "launcher"}),
    awful.key({ modkey, "Shift"  }, "g", 
        function () awful.spawn("steam >> ~/.cache/awesome/steamout 2>> ~/.cache/awesome/steamerr") 
        end,                                                                                {description = "Open steam", group = "launcher"}),
    awful.key({ modkey, "Shift", "Control"  }, "z", 
        function () awful.spawn("flatpak run us.zoom.Zoom") end,                            {description = "Open discord", group = "launcher"}),
    awful.key({ modkey, "Shift"  }, "t", 
        function () awful.spawn('/home/gabe/.scripts/theme set best-dark') end,             {description = "Set theme best dark", group = "launcher"}),
    awful.key({ modkey, "Shift", "Control"  }, "t", 
        function () awful.spawn('/home/gabe/.scripts/theme set best-light') end,            {description = "Set theme best dark", group = "launcher"}),
    awful.key({                  }, "Print", function () awful.spawn("scrt") end,           {description = "Take a screenshot of the full screen", group = "screenshot"}),
    awful.key({ "Shift"          }, "Print", function () awful.spawn("scrt-select") end,    {description = "Take a screenshot of a selection from the screen", group = "screenshot"}),
    awful.key({ modkey, }, "z", function () ddterm:toggle() end,                            {description = "Dropdown terminal", group = "dropdown"}),
    awful.key({ modkey, "Shift" }, "z", function () ddbigterm:toggle() end,                 {description = "Dropdown terminal", group = "dropdown"}),
    awful.key({ modkey, "Shift" }, "p", function () ddpavu:toggle() end,                    {description = "Dropdown audio control", group = "dropdown"}),
    awful.key({ modkey          }, "\\", function () ddwal:toggle() end,                    {description = "Dropdown wallpaper", group = "dropdown"}),

    -- restart and quit
    awful.key({ modkey, "Shift" }, "r", awesome.restart,                                    {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift", "Control"   }, "q", awesome.quit,                          {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05) end,   {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05) end,   {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) 
        end,                                                                                {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) 
        end,                                                                                {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)  
        end,                                                                                {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    
        end,                                                                                {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                
        end,                                                                                {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                
        end,                                                                                {description = "select previous", group = "layout"}),
    awful.key({ modkey },      "r",     function () awful.screen.focused().mypromptbox:run() 
        end,                                                                                {description = "run prompt", group = "launcher"}),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,                                                                          {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,                                                                          {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "b", function() wibars_toggle() end,                              {description = "show or hide wibar(s)", group = "bar"}),
    awful.key({ modkey }, "p", function() menubar.show() end,                               {description = "show the menubar", group = "bar"}),
    awful.key({ modkey, "Shift", "Control"}, "b", function() awful.spawn("kitty --class=kitty-background -e asciiquarium") 
        end,                                                                                {description = "toggle asciiquarium", group = "bar"}),
    awful.key({ modkey }, "Tab", function() awful.spawn("rofi -kb-row-up 'ISO_Left_Tab' -show window -lines 8 -width 40") 
        end,                                                                                {description = "rofi mod tab", group = "hotkeys"}),
  awful.key({ }, 'XF86AudioRaiseVolume', function() volume_widget:inc() end,                     {description = 'volume up', group = 'hotkeys'}),
  awful.key({ }, 'XF86AudioLowerVolume', function() volume_widget:dec() end,                     {description = 'volume down', group = 'hotkeys'}),
  awful.key({ }, 'XF86AudioMute', function() volume_widget:toggle() end,                         {description = 'toggle mute', group = 'hotkeys'}), 
  awful.key({  }, "XF86MonBrightnessUp", function() awful.spawn("brightnessctl set +10%") 
      end,                                                                                  {description = "increase brightness", group = "launcher"}),
  awful.key({  }, "XF86MonBrightnessDown", function() awful.spawn("brightnessctl set 10%-")
      end,                                                                                  {description = "decrease brightness", group = "launcher"})
  )

clientkeys = gears.table.join(

    -- On the fly useless gaps change
  awful.key({ modkey }, "=", function () lain.util.useless_gaps_resize(1) end,              {description = "Increase gaps", group = "hotkeys"}),
  awful.key({ modkey }, "-", function () lain.util.useless_gaps_resize(-1) end,             {description = "Decrease gaps", group = "hotkeys"}),
  awful.key({ modkey,           }, "f", function (c) c.fullscreen = not c.fullscreen c:raise()
        end,                                                                                {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "BackSpace", function (c) c:kill() end,                {description = "close", group = "client"}),
    awful.key({ modkey, "shift"   }, "f",          awful.client.floating.toggle,            {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) 
        end,                                                                                {description = "move to master", group = "client"}),
    awful.key({ modkey, "Shift"   }, "o",      function (c) c:move_to_screen() end,         {description = "move to screen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop end,      {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n", function (c) c.minimized = true end ,             {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m", function (c) c.maximized = not c.maximized c:raise()
        end,                                                                                {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m", function (c) c.maximized_vertical = not 
            c.maximized_vertical c:raise() end ,                                            {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m", function (c) c.maximized_horizontal = not 
            c.maximized_horizontal c:raise() end ,                                          {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function () local screen = awful.screen.focused() local tag = screen.tags[i]
                        if tag then tag:view_only() end end,                                {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9, function () local screen = awful.screen.focused() local tag = screen.tags[i] 
                  if tag then awful.tag.viewtoggle(tag) end end,                            {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function () if client.focus then local tag = client.focus.screen.tags[i]
                          if tag then client.focus:move_to_tag(tag) end end end,            {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function () if client.focus then local tag = client.focus.screen.tags[i]
                          if tag then client.focus:toggle_tag(tag) end end end,             {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
    awful.button({ modkey }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c) end),
    awful.button({ modkey }, 3, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c) end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    {rule_any = {class = { "Picture-in-picture" }}, properties = { floating = true }},

    { rule_any = { 
        class = { "zoom" },
        class = { "chat" },
        }, properties = { floating = true,  }},
    
    { rule_any = { 
        class = { "zoom", "Praat" },
        }, properties = { floating = true }},

    { rule_any = { class = { "Firefox", "qutebrowser" }
        }, properties = { floating = false, opacity = 1}},
    { rule_any = { class = { "kitty-background" }
        }, properties = { floating = true, maximized = true, below = true, skip_taskbar = true, 
            sticky = true, opacity = 1, border_width = 0, focus = false, tag = "9" }},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
