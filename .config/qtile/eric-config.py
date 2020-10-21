from libqtile.config import Key, Screen, Group, Drag, Click, Match, ScratchPad, DropDown
import random
from os import system
from libqtile.lazy import lazy
from libqtile import layout, bar, widget
import json
from libqtile.backend.x11 import xcbq
from typing import List  # noqa: F401
import functools
import gc


class FakeCommand:
    def check(self, whocares):
        gc.collect()
        wrappers = [
            a for a in gc.get_objects() if isinstance(a, functools._lru_cache_wrapper)
        ]
        for wrapper in wrappers:
            wrapper.cache_clear()
        return False



class funcstr(str):
    def func(self, f):
        self.f = f
        return self

    def __getitem__(self, key):
        return self.f()[key]


def getgetcolor(category, color):
    def getcolor():
        with open("/home/mimi/.cache/wal/colors.json") as f:
            colorscheme = json.load(f)
            return colorscheme[category][color]

    return getcolor


backgr = funcstr("#00ff00").func(getgetcolor("special", "background"))
foregr = funcstr("#00ff00").func(getgetcolor("special", "foreground"))
color1 = funcstr("#00ff00").func(getgetcolor("colors", "color1"))
color2 = funcstr("#00ff00").func(getgetcolor("colors", "color2"))
color3 = funcstr("#00ff00").func(getgetcolor("colors", "color3"))

mod = "mod4"
alt = "mod1"
ctrl = "control"
shft = "shft"

keys = [
    Key([mod, ctrl], "a", FakeCommand()),
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, shft], "space", lazy.layout.rotate()),

    Key([mod, shft], "Return", lazy.layout.toggle_split()),
    
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, shft], "q", lazy.window.kill()),

    Key([mod, ctrl], "r", lazy.restart()),
    Key([mod, ctrl, shft], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod], "m", lazy.hide_show_bar()),

    Key([mod, ctrl], "period", lazy.spawn("/home/gabe/.scripts/screens")),
    Key([mod], "period", lazy.spawn("/home/gabe/.scripts/startup-walls")),
    Key([mod, shft], "period", lazy.spawn("/home/gabe/.scripts/startup-walls-light")),
    Key([mod], "comma", lazy.spawn("/home/gabe/.scripts/startup-dark")),
    Key([mod, shft], "comma", lazy.spawn("/home/gabe/.scripts/startup-light")),

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
    "a": Group("h"),
    "s": Group("e"),
    "d": Group("E", label="e"),
    "f": Group("t"),
    "u": Group("arch"),
    "i": Group("comp"),
    "o": Group("algs"),
    # "p": Group("ethc"),
    "z": Group("m"),
    "x": Group("i"),
    "c": Group("s"),
    "v": Group("c"),
}

groups = [_groups[k] for k in _groups]

for k, g in _groups.items():
    keys.extend(
        [
            Key([mod], k, lazy.group[g.name].toscreen()),
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
            Key([mod, shft], k, lazy.window.togroup(g.name)),
        ]
    )

groups.append(
    ScratchPad(
        "scratchpad",
        [
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
                "qutebrowser --config ~/.config/qutebrowser/no-daemon-config.py",
                x=0.2,
                y=0.05,
                width=0.65,
                height=0.9,
                opacity=0.95,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "notes",
                "kitty emacs -nw docs/karma.org",
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
                "kitty zsh -c 'cd ~/music/songs; zsh'",
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
        ],
    )
)

dropdowns = [
    lazy.group["scratchpad"].dropdown_toggle("signal"),
    lazy.group["scratchpad"].dropdown_toggle("notes"),
    lazy.group["scratchpad"].dropdown_toggle("py"),
    lazy.group["scratchpad"].dropdown_toggle("files"),
    lazy.group["scratchpad"].dropdown_toggle("term"),
]

for key_name, dropdown in zip("n m comma period slash".split(), dropdowns):
    keys.append(Key([mod], key_name, dropdown))

with open("/home/gabe/.cache/wal/colors.json") as f:
    colorscheme = json.load(f)

# backgr = colorscheme["special"]["background"]
# foregr = colorscheme["special"]["foreground"]
# color1 = colorscheme["colors"]["color1"]
# color2 = colorscheme["colors"]["color2"]
# color3 = colorscheme["colors"]["color8"]


layouts = [
    layout.MonadTall(
        border_focus=color1,
        border_width=8,
        margin=16,
        ratio=0.56,
        border_normal=backgr,
    ),
    layout.Max(),
]
backgr.layout = layouts[0]
foregr.layout = layouts[0]
color1.layout = layouts[0]
color2.layout = layouts[0]
color3.layout = layouts[0]

widget_defaults = dict(
    font="monospace",
    fontsize=26,
    padding=9,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(foreground=foregr),
                widget.GroupBox(
                    active=foregr,
                    disable_drag=True,
                    this_current_screen_border=color1,
                    other_screen_border=backgr,
                    borderwidth=2,
                ),
                widget.Prompt(foreground=foregr),
                widget.WindowName(markup=False, foreground=backgr),
                widget.Systray(foreground=foregr),
                widget.Clock(foreground=foregr, format="%a the %d  |  %I:%M"),
            ],
            60,
            background=backgr,
            foreground=foregr,
            # opacity=.7,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


follow_mouse_focus = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": " download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},  # gitk
        {"wmclass": "makebranch"},  # gitk
        {"wmclass": "maketag"},  # gitk
        {"wname": "branchdialog"},  # gitk
        {"wname": "pinentry"},  # GPG key password entry
        {"wmclass": "ssh-askpass"},  # ssh-askpass
    ],
    border_focus=color1,
)
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "LG3D"
