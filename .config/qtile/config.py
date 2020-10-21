from libqtile.config import Key, Screen, Group, Drag, Click, DropDown, ScratchPad
from libqtile.lazy import lazy
from libqtile import layout, bar, widget

from typing import List  # noqa: F401

import os
import json


from libqtile.backend.x11 import xcbq
import gc
import functools

class funcstr(str):
    def func(self, f):
        self.f = f
        return self

    def __getitem__(self, key):
        return self.f()[key]


def getgetcolor(category, color):
    def getcolor():
        with open("/home/gabe/.cache/wal/colors.json") as f:
            colorscheme = json.load(f)
            return colorscheme[category][color]

    return getcolor

backgr = funcstr("#00ff00").func(getgetcolor("special", "background"))
foregr = funcstr("#00ff00").func(getgetcolor("special", "foreground"))
color1 = funcstr("#00ff00").func(getgetcolor("colors", "color2"))
color2 = funcstr("#00ff00").func(getgetcolor("colors", "color6"))
color3 = funcstr("#00ff00").func(getgetcolor("colors", "color8"))
color4 = funcstr("#00ff00").func(getgetcolor("colors", "color4"))

mod = "mod4"
alt = "mod1"
ctrl = "control"
shift = "shift"

keys = [
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),
    Key([mod], "space", lazy.layout.next()),
    Key([mod, shift], "space", lazy.layout.rotate()),
    Key([mod, shift], "Return", lazy.layout.toggle_split()),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, shift], "q", lazy.window.kill()),
    Key([mod, ctrl], "r", lazy.restart()),
    Key([mod, ctrl, shift], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod], "m", lazy.hide_show_bar()),

    Key([mod, ctrl], "period", lazy.spawn("/home/gabe/.scripts/screens")),
    Key([mod], "period", lazy.spawn("/home/gabe/.scripts/startup-walls")),
    Key([mod, shift], "period", lazy.spawn("/home/gabe/.scripts/startup-walls-light")),
    Key([mod], "comma", lazy.spawn("/home/gabe/.scripts/startup-dark")),
    Key([mod, shift], "comma", lazy.spawn("/home/gabe/.scripts/startup-light")),

    Key([mod], "Return", lazy.spawn("kitty -e ranger")),
    Key([mod], "semicolon", lazy.spawn("kitty")),
    Key([mod], "e", lazy.spawn('emacsclient -ca "emacs --daemon"')),
    Key([mod], "q", lazy.spawn("qutebrowser")),

    Key([mod, ctrl],"0", lazy.spawn('/home/gabe/.scripts/powermenu.sh')),
    Key([alt], "space", lazy.spawn("/home/gabe/.scripts/rofidrun.sh")),
    Key([], "Print", lazy.spawn('/home/gabe/.scripts/scrotmenu.sh')),
    Key([mod], "Print", lazy.spawn('/home/gabe/.scripts/scrt-select'))
]
_groups = {
    "a": Group("c"),
    "s": Group("o"),
    "d": Group("m"),
    "f": Group("p"),
    "z": Group("u"),
    "x": Group("t"),
    "c": Group("e"),
    "v": Group("r"),
}

groups = [_groups[k] for k in _groups]

for k, g in _groups.items():
    keys.extend(
        [
            Key([mod], k, lazy.group[g.name].toscreen()),
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
            Key([mod, shift], k, lazy.window.togroup(g.name)),
        ]
    )



groups.append(
    ScratchPad("scratchpad",
        [
            # mine
            # DropDown("signal", "signal-desktop-beta",
            #          x=0.5, y=0.1, width=0.35, height=0.6,
            #          on_focus_lost_hide=True),
            # DropDown("term", "kitty",
            #          x=0.2, y=0.2, width=0.5, height=0.3,
            #          on_focus_lost_hide=True),
            # DropDown("music", "kitty -e tuijam",
            #          x=0.2, y=0.1, width=0.3, height=0.7,
            #          on_focus_lost_hide=True),
            # DropDown("pavu", 'pavucontol --name="pavucontrol"',
            #          x=0.3, y=0.1, width=0.4, height=0.4,
            #          on_focus_lost_hide=True),
            # DropDown("emacs", "emacsclient -a '' -c",
            #          x=0.15, y=0.1, width=0.7, height=0.8,
            #          on_focus_lost_hide=True),
            #
            # eric's
            # DropDown("signal", "signal-desktop",
            #          x=0.2, y=0.05, width=0.65, height=0.9,
            #          opacity=0.95,
            #          on_focus_lost_hide=True),
            DropDown(
                "py",
                "kitty python",
                x=0.2,
                y=0.05,
                width=0.5,
                height=0.5,
                opacity=0.80,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "term",
                "kitty",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=0.80,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "browser",
                "qutebrowser",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=0.95,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "notes",
                "kitty emacs -nw ~/docs/Org/notes.org",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=0.8,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "vi",
                "kitty nvim",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=0.8,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "torrent",
                "transmission-gtk",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=0.8,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "audio",
                "pavucontrol",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=0.8,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "music",
                "kitty zsh -c 'tuijam; zsh'",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=0.8,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "files",
                "kitty ranger",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=0.8,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "signal",
                "signal-desktop-beta",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=1,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "discord",
                "discord",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=1,
                on_focus_lost_hide=True,
            ),


        ])
)

dropdowns = [
    lazy.group["scratchpad"].dropdown_toggle("notes"),
    lazy.group["scratchpad"].dropdown_toggle("signal"),
    lazy.group["scratchpad"].dropdown_toggle("browser"),
    lazy.group["scratchpad"].dropdown_toggle("files"),
    lazy.group["scratchpad"].dropdown_toggle("term"),
    lazy.group["scratchpad"].dropdown_toggle("music"),
    lazy.group["scratchpad"].dropdown_toggle("py"),
]

for key_name, dropdown in zip("n m b u i o p".split(), dropdowns):
    keys.append(Key([mod], key_name, dropdown))

# keys.extend([
#     Key([mod], '1', lazy.group['scratchpad'].dropdown_toggle('signal')),
#     Key([mod], '2', lazy.group['scratchpad'].dropdown_toggle('music')),
#     Key([mod], '3', lazy.group['scratchpad'].dropdown_toggle('pavu')),
#     Key([mod], 'e', lazy.group['scratchpad'].dropdown_toggle('emacsclient')),
#     Key([mod], 't', lazy.group['scratchpad'].dropdown_toggle('term')),
#     # Key([mod], '2', lazy.group['scratchpad'].dropdown_toggle('music')),
# ])

# with open('/home/gabe/.cache/wal/colors.json') as f:
    # colorscheme = json.load(f)

# backgr = colorscheme['special']['background']
# foregr = colorscheme['special']['foreground']
# color1 = colorscheme['colors']['color5']
# color2 = colorscheme['colors']['color6']
# color3 = colorscheme['colors']['color2']
# color4 = colorscheme['colors']['color7']

layouts = [
    # layout.Max(margin=20, border_focus=color1, border_normal=backgr),
    layout.Stack(num_stacks=2, margin=15, border_focus=color1, border_normal=backgr, border_width=4),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    layout.MonadTall(margin=15, ratio=.56, border_focus=color1, border_normal=backgr, border_width=4),
    # layout.MonadWide(),
    layout.RatioTile(margin=15, border_focus=color1, border_normal=backgr, border_width=4),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(margin=50, border_focus=color1, border_normal=backgr),
]

widget_defaults = dict(
    fontsize=12,
    padding=3,
    borderwidth=1,
    padding_x=2,
    padding_y=1,
    margin_y=4,
    spacing=0,
    active=foregr,
    foreground=foregr,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(
                    this_current_screen_border=color1,
                    other_screen_border=color3,
                    highlight_method='block',
                    urgent_alert_method='block',
                    active=color3,
                    inactive=foregr
                ),
                widget.Prompt(),
                widget.WindowName(),
                # widget.TextBox("default config", name="default"),
                widget.Systray(),
                widget.ThermalSensor(foreground=foregr, foreground_alert=color2, metric=False, threshold=120, update_interval=10),
                widget.Clock(format='%a %m-%d %H:%M'),
            ],
            24,
            background=backgr
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.disable_floating())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': ' download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wmclass': 'zoom'}, # zoom windows
    {'wmclass': 'praat'}, # praat windows
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
], border_focus=color1, border_width=4)
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# os.system("picom -b --config /home/gabe/.config/picom/picom.conf")

# os.system("setxkbmap -option caps:escape")
