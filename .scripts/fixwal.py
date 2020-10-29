import sys
import json

# Returns None if it can't read the theme
def theme_dict(theme_path):
    if "-fixed.json" in theme_path:
        return
    with open(theme_path, "r") as theme_file:
        theme_str = theme_file.read()

        try:
            theme = json.loads(theme_str)
            return theme
        except json.decoder.JSONDecodeError:
            print("JSON Error decoding", theme_str, "from", theme_path)

# Returns None if nothing's wrong with the theme
def fix_theme(theme):

    if theme["special"]["background"] == "#000000" and theme["special"]["foreground"] == "#ffffff":

        print("theme {} is wrong".format(theme_path))

        print("changing background {} to color0 {}".format(
            theme["special"]["background"],
            theme["colors"]["color0"]
        ))
        theme["special"]["background"] = theme["colors"]["color0"]

        print("changing foreground {} to color15 {}".format(
            theme["special"]["foreground"],
            theme["colors"]["color15"]
        ))
        theme["special"]["foreground"] = theme["colors"]["color15"]

        if theme["special"]["cursor"] in ["#ffffff", "#000000"]:
            print("changing cursor {} to color15 {}".format(
                theme["special"]["cursor"],
                theme["colors"]["color15"]
            ))
            theme["special"]["cursor"] = theme["colors"]["color15"]

        return theme

if __name__ == "__main__":
    themes = sys.argv[1:]
    for theme_path in themes:
        theme = theme_dict(theme_path)
        if not theme:
            continue
        fixed_theme = fix_theme(theme)
        if not fixed_theme:
            continue
        new_theme_path = theme_path.split(".json")[0] + "-fixed.json"
        with open(new_theme_path, "w") as new_theme_file:
            json_theme_str = json.dumps(fixed_theme, indent=2)
            new_theme_file.write(json_theme_str)
