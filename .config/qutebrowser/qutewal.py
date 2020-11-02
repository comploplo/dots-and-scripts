import json
import os

qutewal_dynamic_loading = True

home = os.getenv("HOME")
colors_relative = ".cache/wal/colors.json"
daemon_relative = ".config/qutebrowser/qutewald.py"
colors_absolute = os.path.join(home, colors_relative)
daemon_absolute = os.path.join(home, daemon_relative)


def rgb2hex(t):
    return "#" + "".join(tuple(map(lambda n: hex(n)[2:].rjust(2, "0")[-2:], t)))


def hex2rgb(s):
    return tuple(map(lambda n: int(n, 16), [s[1:3], s[3:5], s[5:7]]))


def dark(c):
    return rgb2hex([i - 5 if i >= 5 else i + 5 for i in hex2rgb(c)])


def light(c):
    return rgb2hex([i + 9 if i <= 255 - 9 else i - 9 for i in hex2rgb(c)])


if os.path.isfile(colors_absolute):
    with open(colors_absolute) as colorfile:
        colors = json.load(colorfile)
        cursor = colors["special"]["cursor"]
        background = colors["special"]["background"]
        foreground = colors["special"]["foreground"]
        black = colors["colors"]["color0"]
        white = colors["colors"]["color7"]
        gray = colors["colors"]["color8"]
        red = colors["colors"]["color1"]
        green = colors["colors"]["color2"]
        yellow = colors["colors"]["color3"]
        blue = colors["colors"]["color4"]
        magenta = colors["colors"]["color5"]
        cyan = colors["colors"]["color6"]

    # Background color of the completion widget category headers.
    # Type: QssColor
    c.colors.completion.category.bg = dark(background)

    # Bottom border color of the completion widget category headers.
    # Type: QssColor
    c.colors.completion.category.border.bottom = background

    # Top border color of the completion widget category headers.
    # Type: QssColor
    c.colors.completion.category.border.top = background

    # Foreground color of completion widget category headers.
    # Type: QtColor
    c.colors.completion.category.fg = foreground

    # Background color of the completion widget for even rows.
    # Type: QssColor
    c.colors.completion.even.bg = background

    # Background color of the completion widget for odd rows.
    # Type: QssColor
    c.colors.completion.odd.bg = background

    # Text color of the completion widget.
    # Type: QtColor
    c.colors.completion.fg = foreground

    # Background color of the selected completion item.
    # Type: QssColor
    c.colors.completion.item.selected.bg = gray

    # Bottom border color of the selected completion item.
    # Type: QssColor
    c.colors.completion.item.selected.border.bottom = background

    # Top border color of the completion widget category headers.
    # Type: QssColor
    c.colors.completion.item.selected.border.top = background

    # Foreground color of the selected completion item.
    # Type: QtColor
    c.colors.completion.item.selected.fg = foreground

    # Foreground color of the matched text in the completion.
    # Type: QssColor
    c.colors.completion.match.fg = yellow

    # Color of the scrollbar in completion view
    # Type: QssColor
    c.colors.completion.scrollbar.bg = background

    # Color of the scrollbar handle in completion view.
    # Type: QssColor
    c.colors.completion.scrollbar.fg = gray

    # Background color for the download bar.
    # Type: QssColor
    c.colors.downloads.bar.bg = background

    # Background color for downloads with errors.
    # Type: QtColor
    c.colors.downloads.error.bg = red

    # Foreground color for downloads with errors.
    # Type: QtColor
    c.colors.downloads.error.fg = foreground

    # Color gradient stop for download backgrounds.
    # Type: QtColor
    c.colors.downloads.stop.bg = cyan

    # Color gradient interpolation system for download backgrounds.
    # Type: ColorSystem
    # Valid values:
    #   - rgb: Interpolate in the RGB color system.
    #   - hsv: Interpolate in the HSV color system.
    #   - hsl: Interpolate in the HSL color system.
    #   - none: Don't show a gradient.
    c.colors.downloads.system.bg = "none"

    # Background color for hints. Note that you can use a `rgba(...)` value
    # for transparency.
    # Type: QssColor
    c.colors.hints.bg = background

    # Font color for hints.
    # Type: QssColor
    c.colors.hints.fg = foreground

    # Font color for the matched part of hints.
    # Type: QssColor
    c.colors.hints.match.fg = foreground
    # Background color of the keyhint widget.
    # Type: QssColor
    c.colors.keyhint.bg = background

    # Text color for the keyhint widget.
    # Type: QssColor
    c.colors.keyhint.fg = foreground

    # Highlight color for keys to complete the current keychain.
    # Type: QssColor
    c.colors.keyhint.suffix.fg = yellow

    # Background color of an error message.
    # Type: QssColor
    c.colors.messages.error.bg = red

    # Border color of an error message.
    # Type: QssColor
    c.colors.messages.error.border = yellow

    # Foreground color of an error message.
    # Type: QssColor
    c.colors.messages.error.fg = foreground

    # Background color of an info message.
    # Type: QssColor
    c.colors.messages.info.bg = blue

    # Border color of an info message.
    # Type: QssColor
    c.colors.messages.info.border = blue

    # Foreground color an info message.
    # Type: QssColor
    c.colors.messages.info.fg = foreground

    # Background color of a warning message.
    # Type: QssColor
    c.colors.messages.warning.bg = red

    # Border color of a warning message.
    # Type: QssColor
    c.colors.messages.warning.border = yellow

    # Foreground color a warning message.
    # Type: QssColor
    c.colors.messages.warning.fg = foreground

    # Background color for prompts.
    # Type: QssColor
    c.colors.prompts.bg = background

    # # Border used around UI elements in prompts.
    # # Type: String
    c.colors.prompts.border = "1px solid " + background

    # Foreground color for prompts.
    # Type: QssColor
    c.colors.prompts.fg = foreground

    # Background color for the selected item in filename prompts.
    # Type: QssColor
    c.colors.prompts.selected.bg = magenta

    # Background color of the statusbar in caret mode.
    # Type: QssColor
    c.colors.statusbar.caret.bg = cyan

    # Foreground color of the statusbar in caret mode.
    # Type: QssColor
    c.colors.statusbar.caret.fg = cursor

    # Background color of the statusbar in caret mode with a selection.
    # Type: QssColor
    c.colors.statusbar.caret.selection.bg = cyan

    # Foreground color of the statusbar in caret mode with a selection.
    # Type: QssColor
    c.colors.statusbar.caret.selection.fg = foreground

    # Background color of the statusbar in command mode.
    # Type: QssColor
    c.colors.statusbar.command.bg = background

    # Foreground color of the statusbar in command mode.
    # Type: QssColor
    c.colors.statusbar.command.fg = foreground

    # Background color of the statusbar in private browsing + command mode.
    # Type: QssColor
    c.colors.statusbar.command.private.bg = background

    # Foreground color of the statusbar in private browsing + command mode.
    # Type: QssColor
    c.colors.statusbar.command.private.fg = foreground

    # Background color of the statusbar in insert mode.
    # Type: QssColor
    c.colors.statusbar.insert.bg = green

    # Foreground color of the statusbar in insert mode.
    # Type: QssColor
    c.colors.statusbar.insert.fg = background

    # Background color of the statusbar.
    # Type: QssColor
    c.colors.statusbar.normal.bg = background

    # Foreground color of the statusbar.
    # Type: QssColor
    c.colors.statusbar.normal.fg = foreground

    # Background color of the statusbar in passthrough mode.
    # Type: QssColor
    c.colors.statusbar.passthrough.bg = blue

    # Foreground color of the statusbar in passthrough mode.
    # Type: QssColor
    c.colors.statusbar.passthrough.fg = foreground

    # Background color of the statusbar in private browsing mode.
    # Type: QssColor
    c.colors.statusbar.private.bg = "#000000"

    # Foreground color of the statusbar in private browsing mode.
    # Type: QssColor
    c.colors.statusbar.private.fg = "#000000"

    # Background color of the progress bar.
    # Type: QssColor
    c.colors.statusbar.progress.bg = foreground

    # Foreground color of the URL in the statusbar on error.
    # Type: QssColor
    c.colors.statusbar.url.error.fg = red

    # Default foreground color of the URL in the statusbar.
    # Type: QssColor
    c.colors.statusbar.url.fg = foreground

    # Foreground color of the URL in the statusbar for hovered links.
    # Type: QssColor
    c.colors.statusbar.url.hover.fg = blue

    # Foreground color of the URL in the statusbar on successful load
    # (http).
    # Type: QssColor
    c.colors.statusbar.url.success.http.fg = foreground

    # Foreground color of the URL in the statusbar on successful load
    # (https).
    # Type: QssColor
    c.colors.statusbar.url.success.https.fg = gray

    # Foreground color of the URL in the statusbar when there's a warning.
    # Type: QssColor
    c.colors.statusbar.url.warn.fg = red

    # Background color of the tab bar.
    # Type: QtColor
    c.colors.tabs.bar.bg = background

    # Background color of unselected even tabs.
    # Type: QtColor

    # Foreground color of unselected even tabs.
    # Type: QtColor

    # Color for the tab indicator on errors.
    # Type: QtColor
    c.colors.tabs.indicator.error = red

    # Color gradient start for the tab indicator.
    # Type: QtColor
    c.colors.tabs.indicator.start = background

    # Color gradient end for the tab indicator.
    # Type: QtColor
    c.colors.tabs.indicator.stop = foreground

    # Color gradient interpolation system for the tab indicator.
    # Type: ColorSystem
    # Valid values:
    #   - rgb: Interpolate in the RGB color system.
    #   - hsv: Interpolate in the HSV color system.
    #   - hsl: Interpolate in the HSL color system.
    #   - none: Don't show a gradient.
    c.colors.tabs.indicator.system = "none"

    # Background color of unselected tabs.
    # Type: QtColor
    c.colors.tabs.odd.bg = dark(background)
    c.colors.tabs.even.bg = light(background)

    # Foreground color of unselected tabs.
    # Type: QtColor
    c.colors.tabs.even.fg = foreground
    c.colors.tabs.odd.fg = foreground

    # Background color of selected tabs.
    # Type: QtColor
    c.colors.tabs.selected.even.bg = dark(magenta)
    c.colors.tabs.selected.odd.bg = magenta

    # Foreground color of selected even tabs.
    # Type: QtColor
    c.colors.tabs.selected.even.fg = background
    c.colors.tabs.selected.odd.fg = background

    # Background color of selected odd tabs.
    # Type: QtColor

    # Foreground color of selected odd tabs.
    # Type: QtColor

    # Background color for webpages if unset (or empty to use the theme's
    # color)
    # Type: QtColor
    c.colors.webpage.bg = foreground

    ddg = "kae={}&kp=-1&k1=-1&kam=osm&kt=monospace&k7={}&kx={}&kj={}&kaa={}"
    ddg = ddg.format(background, background, red, background, yellow)
    c.url.default_page = "https://start.duckduckgo.com/?" + ddg
    c.url.start_pages = ["https://start.duckduckgo.com/?" + ddg]
    c.url.searchengines["DEFAULT"] = "https://duckduckgo.com/?q={}&" + ddg

    """
    if qutewal_dynamic_loading or bool(os.getenv("QUTEWAL_DYNAMIC_LOADING")):
        import signal
        import subprocess
        import prctl

        # start iqutefy to refresh colors on the fly
        qutewald = subprocess.Popen(
            [daemon_absolute, colors_absolute],
            preexec_fn=lambda: prctl.set_pdeathsig(signal.SIGTERM),
        )

    """
