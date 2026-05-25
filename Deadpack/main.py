import os
from pathlib import Path
from shutil import which

CONFIG_DIR = Path.home() / ".config"

IGNORE = {
    "gtk-3.0",
    "fontconfig",
    "dconf",
    "pulse",
    "menus",
    "procps",
    "autostart",
    "xfce4",
}

Matching = {
    "GIMP": "gimp",
    "Code - OSS": "code-oss",
    "obs-studio": "obs",
    "mozilla": "firefox",
    "helix": "hx",
}


for subdir in CONFIG_DIR.iterdir():
    if subdir.is_dir():
        app_name = subdir.name
        excutable = which(app_name)

        if app_name in IGNORE:
            continue

        for k, v in Matching.items():
            if app_name == k:
                excutable = which(v)

        if excutable:
            pass
            # print(f"Installed {app_name}")
        else:
            print(f"trash {subdir}")
            # print(f"Not avail {app_name} -> {subdir}")
